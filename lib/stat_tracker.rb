require 'CSV'
require_relative './game.rb'
require_relative './team.rb'
require_relative './game_team.rb'
require 'pry'

class StatTracker
  attr_reader :game, :team, :game_team

  def initialize(game, team, game_team)
    @game = game
    @team = team
    @game_team = game_team
  end

  def self.from_csv(files)
    game = Game.new
    game.to_data(files[:games])
    team = Team.new
    team.to_data(files[:teams])
    game_team = GameTeam.new
    game_team.to_data(files[:game_teams])
    stat_tracker = StatTracker.new(game, team, game_team)
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def biggest_blowout
    @game.biggest_blowout
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def average_goals_per_game
    @game.average_goals_per_game
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end

  def count_of_teams
    @team.count_of_teams
  end

  def best_offense
    team_id = @game_team.best_offense
    @team.find_name(team_id)
  end

  def worst_offense
    team_id = @game_team.worst_offense
    @team.find_name(team_id)
  end

  def highest_scoring_visitor
    team_id = @game_team.highest_scoring_visitor
    @team.find_name(team_id)
  end

  def highest_scoring_home_team
    team_id = @game_team.highest_scoring_home_team
    @team.find_name(team_id)
  end

  def lowest_scoring_visitor
    team_id = @game_team.lowest_scoring_visitor
    @team.find_name(team_id)
  end

  def lowest_scoring_home_team
    team_id = @game_team.lowest_scoring_home_team
    @team.find_name(team_id)
  end

  def winningest_team
    team_id = @game_team.winningest_team
    @team.find_name(team_id)
  end

  def best_fans
    team_id = @game_team.best_fans
    @team.find_name(team_id)
  end

  def worst_fans
    team_ids = @game_team.worst_fans
    team_ids.map { |id| @team.find_name(id) }
  end

  def best_defense
    team_id = @game_team.best_defense
    @team.find_name(team_id)
  end

  def worst_defense
    team_id = @game_team.worst_defense
    @team.find_name(team_id)
  end

  def team_info(team_id)
    @team.team_info(team_id)
  end

  def best_season(team_id)
    games = @game_team.game_per_team(team_id)
    @game.best_season(games)
  end

  def worst_season(team_id)
    games = @game_team.game_per_team(team_id)
    @game.worst_season(games)
  end

  def average_win_percentage(team_id)
    @game_team.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    id = @game_team.favorite_opponent(team_id)
    @team.find_name(id)
  end

  def rival(team_id)
    id = @game_team.rival(team_id)
    @team.find_name(id)
  end

  def biggest_team_blowout(team_id)
    @game_team.biggest_team_blowout(team_id)
  end

  def worst_loss(team_id)
    @game_team.worst_loss(team_id)
  end

  def head_to_head(team_id)
    result = @game_team.opponents_results(team_id)
    team_names = result.keys.map { |key| @team.find_name(key) }
    team_names.zip(result.values).to_h
  end

  def seasonal_summary(team_id)
    @game.seasonal_summary(team_id)
  end

  def biggest_bust(season_id)
    games = @game.by_season_type(season_id)
    team_id = @game_team.biggest_bust(games)
    @team.find_name(team_id)
  end

  def biggest_surprise(season_id)
    games = @game.by_season_type(season_id)
    team_id = @game_team.biggest_surprise(games)
    @team.find_name(team_id)
  end

  def winningest_coach(season_id)
    game_ids = @game.get_season_games(season_id)
    @game_team.winningest_coach(game_ids)
  end

  def worst_coach(season_id)
    game_ids = @game.get_season_games(season_id)
    @game_team.worst_coach(game_ids)
  end

  def most_accurate_team(season_id)
    game_ids = @game.get_season_games(season_id)
    team_id = @game_team.most_accurate_team(game_ids)
    @team.find_name(team_id)
  end

  def least_accurate_team(season_id)
    game_ids = @game.get_season_games(season_id)
    team_id = @game_team.least_accurate_team(game_ids)
    @team.find_name(team_id)
  end

  def most_hits(season_id)
    game_ids = @game.get_season_games(season_id)
    team_id = @game_team.most_hits(game_ids)
    @team.find_name(team_id)
  end

  def fewest_hits(season_id)
    game_ids = @game.get_season_games(season_id)
    team_id = @game_team.fewest_hits(game_ids)
    @team.find_name(team_id)
  end
end
