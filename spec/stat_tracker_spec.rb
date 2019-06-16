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
    expect(@stat_tracker.game_team.content.count).to eq 6
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
      '20122013' => 6,
      '20132014' => 3
    }

    expect(@stat_tracker.count_of_games_by_season).to eq result
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq 5.33
  end

  it '#average_goals_by_season' do
    result = { '20122013' => 5.0, '20132014' => 6.0 }

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

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq 'Rangers'
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq 'Bruins'
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq 'Bruins'
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq 'Rangers'
  end

  it '#winningest_team' do
    expect(@stat_tracker.winningest_team).to eq 'Bruins'
  end

  it '#best_fans' do
    expect(@stat_tracker.best_fans).to eq 'Bruins'
  end

  it '#worst_fans' do
    expect(@stat_tracker.worst_fans).to eq []
  end

  it '#best_defense' do
    expect(@stat_tracker.best_defense).to eq 'Bruins'
  end

  it '#worst_defense' do
    expect(@stat_tracker.worst_defense).to eq 'Rangers'
  end

  it '#team_info' do
    result = {
      'team_id' => '1',
      'franchise_id' => '23',
      'short_name' => 'New Jersey',
      'team_name' => 'Devils',
      'abbreviation' => 'NJD',
      'link' => '/api/v1/teams/1'
    }

    expect(@stat_tracker.team_info('1')).to eq result
  end

  it '#best_season' do
    expect(@stat_tracker.best_season('3')).to eq '20122013'
  end

  it '#worst_season' do
    expect(@stat_tracker.worst_season('3')).to eq '20122013'
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage('6')).to eq 1.0
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored('6')).to eq 5
  end

  it '#fewest_goals_scored' do
    expect(@stat_tracker.fewest_goals_scored('6')).to eq 2
  end

  it '#favorite_opponent' do
    expect(@stat_tracker.favorite_opponent('6')).to eq 'Rangers'
  end

  it '#rival' do
    expect(@stat_tracker.rival('6')).to eq 'Rangers'
  end
end
