require 'CSV'

class GameTeam
  attr_reader :content

  def initialize
    @content = []
  end

  def to_data(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @content << row
    end
  end

  def best_offense
    total_goals_by_team.max_by { |key,value| value }[0]
  end

  def worst_offense
    total_goals_by_team.min_by { |key,value| value }[0]
  end

  def total_goals_by_team
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      total = goals.inject(&:+)
      goals_by_team[key] = total/ goals.count.to_f
    end
  end

  def highest_scoring_visitor
    away = hoa_goals('away')
    average(away, 'max')
  end

  def highest_scoring_home_team
    home = hoa_goals('home')
    average(home, 'max')
  end

  def lowest_scoring_visitor
    away = hoa_goals('away')
    average(away, 'min')
  end

  def lowest_scoring_home_team
    home = hoa_goals('home')
    average(home, 'min')
  end

  def hoa_goals(status)
    group = @content.group_by {|row| row[:hoa] == status }[true]
    goals_by_team = group.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      goals_by_team[key] = goals.inject(&:+)
    end
  end

  def games_count_by_team
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each { |key, value| goals_by_team[key] = value.count.to_f }
  end

  def average(type, status)
    game_count = games_count_by_team
    type.each { |key, value| type[key] = value/game_count[key] }
    if status == 'max'
      type.max_by { |key,value| value }[0]
    else
      type.min_by { |key,value| value }[0]
    end
  end

  def winningest_team
    wins = win_count
    average(wins, 'max')
  end

  def win_count
    wins = @content.group_by { |row| row[:won] }['TRUE']
    win_count = wins.group_by { |row| row[:team_id] }
    win_count.each { |key, value| win_count[key] = value.count }
  end

  def best_fans
    wins = @content.group_by { |row| row[:won] }['TRUE']
    teams = wins.group_by {|row| row[:team_id]}
    teams.each do |key, value|
      teams[key] = value.group_by { |row| row[:hoa] }
    end
    teams.each do |k, v|
      v.each do |key, value|
        v[key] = value.count
      end
    end
    game_count = games_count_by_team

    teams.each do |k, v|
      v.each do |key, value|
        v[key] = value/game_count[k]
      end
    end

    teams.each do |k,v|
      v['dif'] = (v['home'] - v['away']).abs
    end
    teams.max_by { |key,value| value['dif'] }[0]
  end
end
