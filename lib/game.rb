require 'CSV'
require 'pry'

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

  def find_all_team_games(team_id)
    @content.find_all do |row|
      row[:away_team_id] == team_id || row[:home_team_id] == team_id
    end
  end

  def seasonal_summary(team_id)
    games = find_all_team_games(team_id)
    seasons = games.group_by { |r| r[:season] }
    seasons.each { |k, v| seasons[k] = v.group_by { |r| r[:type] } }

    seasons.each do |season, type|
      type.each do |letter, rows|
        team_goals = team_goals(rows, team_id)
        opponent_goals = opponent_goals(rows, team_id)
        wins = wins(rows, team_id)
        games = rows.count.to_f
        type[letter] = summary(wins, games, team_goals, opponent_goals)
      end
    end

    seasons.each do |season, type|
      seasons[season] = {
        postseason: seasons[season]['P'].nil? ? null_summary : seasons[season]['P'],
        regular_season: seasons[season]['R'].nil? ? null_summary : seasons[season]['R']
      }
    end
  end

  def team_goals(rows, team_id)
    rows.inject(0) do |sum, row|
      value = if row[:away_team_id] == team_id
        row[:away_goals].to_i
      else
        row[:home_goals].to_i
      end
      sum + value
    end
  end

  def opponent_goals(rows, team_id)
    rows.inject(0) do |sum, row|
      value = if row[:away_team_id] != team_id
        row[:away_goals].to_i
      else
        row[:home_goals].to_i
      end
      sum + value
    end
  end

  def wins(rows, team_id)
    rows.count do |row|
      if row[:away_team_id] == team_id
        row[:away_goals].to_i - row[:home_goals].to_i > 0
      else
        row[:home_goals].to_i - row[:away_goals].to_i > 0
      end
    end
  end

  def summary(wins, games, team_goals, opponent_goals)
      {
        win_percentage: (wins/games).round(2),
        total_goals_scored: team_goals,
        total_goals_against: opponent_goals,
        average_goals_scored: (team_goals/games).round(2),
        average_goals_against: (opponent_goals/games).round(2)
      }
  end

  def null_summary
    {
      :win_percentage=>0.0,
      :total_goals_scored=>0,
      :total_goals_against=>0,
      :average_goals_scored=>0.0,
      :average_goals_against=>0.0
    }
  end
end
