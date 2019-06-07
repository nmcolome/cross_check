require 'CSV'
require_relative './game.rb'
require_relative './team.rb'
require_relative './game_team.rb'

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
end
