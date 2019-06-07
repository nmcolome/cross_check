require './spec/test_helper.rb'
require './lib/stat_tracker.rb'
require 'pry'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/game_fixture.csv'
    team_path = './data/team_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'

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

  it '::from_csv' do
    expect(@stat_tracker.game.content.count).to eq 4
    expect(@stat_tracker.team.content.count).to eq 5
    expect(@stat_tracker.game_team.content.count).to eq 7
  end

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq 7
  end

  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 3
  end

  it '#biggest_blowout' do
    expect(@stat_tracker.biggest_blowout).to eq 3
  end
end