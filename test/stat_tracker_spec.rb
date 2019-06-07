require './test/test_helper.rb'
require './lib/stat_tracker.rb'
require 'pry'

RSpec.describe StatTracker do
  it 'exists' do
    @stat_tracker = StatTracker.new

    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '#from_csv' do
    @stat_tracker = StatTracker.new

    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    expect(@stat_tracker.from_csv(locations)).to be_an_instance_of Hash
    expect(@stat_tracker.content).to be_an_instance_of Hash
    expect(@stat_tracker.content[:games].count).to eq 7441
    expect(@stat_tracker.content[:teams].count).to eq 33
    expect(@stat_tracker.content[:game_teams].count).to eq 14882
  end
end