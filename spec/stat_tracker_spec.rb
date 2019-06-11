require './spec/spec_helper.rb'
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
    expect(@stat_tracker.game.content.count).to eq 9
    expect(@stat_tracker.team.content.count).to eq 6
    expect(@stat_tracker.game_team.content.count).to eq 7
  end

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq 9
  end

  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 3
  end

  it '#biggest_blowout' do
    expect(@stat_tracker.biggest_blowout).to eq 5
  end

  it '#percentage_home_wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.78
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.22
  end

  it '#count_of_games_by_season' do
    result = {
      "20122013" => 6,
      "20132014" => 3
    }

    expect(@stat_tracker.count_of_games_by_season).to eq result
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq 5.33
  end

  it '#average_goals_by_season' do
    result = {
      "20122013" => 5.0,
      "20132014" => 6.0
    }

    expect(@stat_tracker.average_goals_by_season).to eq result
  end

  it '#count_of_teams' do
    expect(@stat_tracker.count_of_teams).to eq 6
  end

  it '#best_offense' do
    expect(@stat_tracker.best_offense).to eq 'Bruins'
  end

  it '#worst_offense' do
    expect(@stat_tracker.worst_offense).to eq 'Rangers'
  end
end