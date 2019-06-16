require 'CSV'
require 'pry'
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
    total_goals_by_team.max_by { |key, value| value }[0]
  end

  def worst_offense
    total_goals_by_team.min_by { |key, value| value }[0]
  end

  def total_goals_by_team
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      total = goals.inject(&:+)
      goals_by_team[key] = total / goals.count.to_f
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
    group = @content.group_by { |row| row[:hoa] == status }[true]
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
    type.each { |key, value| type[key] = value / game_count[key] }
    if status == 'max'
      type.max_by { |key, value| value }[0]
    else
      type.min_by { |key, value| value }[0]
    end
  end

  def winningest_team
    wins = win_count
    average(wins, 'max')
  end

  def win_count
    win_count = win_groups
    win_count.each { |key, value| win_count[key] = value.count }
  end

  def win_groups
    wins = @content.group_by { |row| row[:won] }['TRUE']
    wins.group_by { |row| row[:team_id] }
  end

  def best_fans
    teams = home_away_difference
    teams.each { |k, v| v['dif'] = (v['home'] - v['away']).abs }
    teams.max_by { |key, value| value['dif'] }[0]
  end

  def home_away_difference
    teams = win_groups
    group_by_hoa(teams)
    game_count = games_count_by_team
    percentage_wins(teams, game_count)
  end

  def group_by_hoa(teams)
    teams.each do |key, value|
      teams[key] = value.group_by { |row| row[:hoa] }
    end
    value_count(teams)
  end

  def value_count(teams)
    teams.each do |k, v|
      v.each { |key, value| v[key] = value.count }
    end
  end

  def percentage_wins(group, count)
    group.each do |k, v|
      v.each { |key, value| v[key] = value / count[k] }
    end
  end

  def worst_fans
    teams = home_away_difference
    teams.each { |k, v| v['dif'] = (v['away'] - v['home']) }
    result = teams.find_all { |k, v| v['dif'] > 0 }
    result.map { |e| e[0] }
  end

  def best_defense
    goals = ga_calculation
    average(goals, 'min')
  end

  def worst_defense
    goals = ga_calculation
    average(goals, 'max')
  end

  def goals_allowed(goals, index_one, index_two)
    if goals[index_one[:team_id]]
      goals[index_one[:team_id]] += index_two[:goals].to_i
    else
      goals[index_one[:team_id]] = index_two[:goals].to_i
    end
  end

  def goals_switch(game, goals)
    [0, 1].each do |index|
      if index.odd?
        index_one = game[1][0]
        index_two = game[1][1]
      else
        index_one = game[1][1]
        index_two = game[1][0]
      end
      goals_allowed(goals, index_one, index_two)
    end
  end

  def ga_calculation
    games = @content.group_by { |row| row[:game_id] }
    goals = {}
    games.each { |group| goals_switch(group, goals) }
    goals
  end

  def game_per_team(team_id)
    @content.find_all { |row| row[:team_id] == team_id }
  end

  def average_win_percentage(team_id)
    games = game_per_team(team_id)
    wins = games.count { |row| row[:won] == 'TRUE' }
    total = games.count.to_f
    (wins / total).round(2)
  end

  def most_goals_scored(team_id)
    games = game_per_team(team_id)
    goals = games.map { |r| r[:goals].to_i }
    goals.max
  end

  def fewest_goals_scored(team_id)
    games = game_per_team(team_id)
    goals = games.map { |r| r[:goals].to_i }
    goals.min
  end

  def favorite_opponent(team_id)
    teams = opponents_results(team_id)
    fave_opp = teams.values.max
    teams.key(fave_opp)
  end

  def rival(team_id)
    teams = opponents_results(team_id)
    rival = teams.values.min
    teams.key(rival)
  end

  def team_opponents(team_id)
    games = game_per_team(team_id)
    game_ids = games.map {|row| row[:game_id]}
    games = game_ids.map { |id| @content.find_all { |r| r[:game_id] == id } }
    games.flatten.find_all { |row| row[:team_id] != team_id }
  end

  def opponents_results(team_id)
    opponents = team_opponents(team_id)
    teams = opponents.group_by { |row| row[:team_id] }
    teams.each do |k,v|
      teams[k] = v.count {|row| row[:won] == 'FALSE'} / v.count.to_f
    end
  end
end
