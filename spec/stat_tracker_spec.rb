require './spec/test_helper.rb'
require './lib/stat_tracker.rb'
require 'pry'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '#from_csv' do
    expect(@stat_tracker.game.content.count).to eq 7441
    expect(@stat_tracker.team.content.count).to eq 33
    expect(@stat_tracker.game_team.content.count).to eq 14882
  end
end