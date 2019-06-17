require 'CSV'

class Game
  attr_reader :content

  def initialize
    @content = []
  end

  def to_data(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @content << row
    end
  end

  def scores_sum
    @content.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }
  end

  def highest_total_score
    scores_sum.max
  end

  def lowest_total_score
    scores_sum.min
  end

  def biggest_blowout
    diff = @content.map { |row| (row[:home_goals].to_i - row[:away_goals].to_i).abs }
    diff.max
  end

  def percentage_home_wins
    home = @content.count { |row| row[:outcome].split(' ')[0] == 'home' }
    (home.to_f / @content.count).round(2)
  end

  def percentage_visitor_wins
    away = @content.count { |row| row[:outcome].split(' ')[0] == 'away' }
    (away.to_f / @content.count).round(2)
  end

  def count_of_games_by_season
    groups = @content.group_by { |row| row[:season] }
    result = {}
    groups.each { |key, value| result[key] = value.count }
    result
  end

  def average_goals_per_game
    average_goals(@content)
  end

  def average_goals_by_season
    groups = @content.group_by { |row| row[:season] }
    result = {}

    groups.each { |key, value| result[key] = average_goals(value) }
    result
  end

  def average_goals(rows)
    goals = rows.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }
    (goals.inject(:+) / goals.count.to_f).round(2)
  end

  def best_season(games)
    data = season_finder(games)
    seasons = win_percentages(data)
    win_percentage = seasons.values.max
    seasons.key(win_percentage)
  end

  def worst_season(games)
    data = season_finder(games)
    seasons = win_percentages(data)
    win_percentage = seasons.values.min
    seasons.key(win_percentage)
  end

  def season_finder(games)
    data = games.map { |row| { game_id: row[:game_id], won: row[:won] } }

    data.each do |pair|
      season = @content.find { |row| row[:game_id] == pair[:game_id] }
      pair[:season] = season[:season]
    end
  end

  def win_percentages(data)
    seasons = data.group_by { |h| h[:season] }
    seasons.each do |key, value|
      wins = value.count { |r| r[:won] == 'TRUE' }
      total = value.count.to_f
      seasons[key] = (wins / total)
    end
  end

  def seasonal_summary(team_id)
    games = @content.find_all do |r|
      r[:away_team_id] == team_id || r[:home_team_id] == team_id
    end
    seasons = games.group_by { |r| r[:season] }
    seasons.each do |k, v|
      seasons[k] = v.group_by { |r| r[:type] }
    end

    summary = {}

    seasons.each do |season, type|
      type.each do |letter, rows|
        team_goals = rows.inject(0) do |sum, r|
          value = if r[:away_team_id] == team_id
            r[:away_goals].to_i
          else
            r[:home_goals].to_i
          end
          sum + value
        end
        opponent_goals = rows.inject(0) do |sum, r|
          value = if r[:away_team_id] != team_id
            r[:away_goals].to_i
          else
            r[:home_goals].to_i
          end
          sum + value
        end
        matches = rows.count.to_f
        wins = rows.count do |r|
          if r[:away_team_id] == team_id
            r[:away_goals].to_i - r[:home_goals].to_i > 0
          else
            r[:home_goals].to_i - r[:away_goals].to_i > 0
          end
        end
        result = {
          win_percentage: wins/matches,
          total_goals_scored: team_goals,
          total_goals_against: opponent_goals,
          average_goals_scored: team_goals/matches,
          average_goals_against: opponent_goals/matches
        }
        type[letter] = result
      end
      type.map do |k,v|
        if k == 'P'
          new_value = {postseason: v}
        else
          new_value = {regular_season: v}
        end
        summary[season] = new_value
      end
    end
    summary
  end
end
