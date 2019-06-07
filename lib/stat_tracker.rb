require 'CSV'
require './lib/game.rb'
require './lib/team.rb'
# require 'pry'

class StatTracker
  attr_reader :game, :team

  def initialize(game, team)
    @game = game
    @team = team
  end

  def self.from_csv(files)
    game = Game.new
    game.to_data(files[:games])
    team = Team.new
    team.to_data(files[:teams])
    stat_tracker = StatTracker.new(game, team)
  end
end
