require 'CSV'
require './lib/game.rb'
require './lib/team.rb'
require './lib/game_team.rb'
# require 'pry'

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
end
