require './spec/spec_helper.rb'
require './lib/game_team.rb'
require 'pry'

RSpec.describe GameTeam do
  before(:all) do
    @game_team_fixture = './data/game_teams_fixture.csv'

    @game_team = GameTeam.new
  end

  it 'exists' do
    expect(@game_team).to be_an_instance_of GameTeam
  end

  it 'has @content' do
    expect(@game_team.content).to eq []
  end

  it '#to_data adds content based on csv' do
    @game_team.to_data(@game_team_fixture)
    expect(@game_team.content).to be_an_instance_of Array
    expect(@game_team.content.count).to eq 6
    expect(@game_team.content[0][:game_id]).to eq '2012030221'
  end

  it '#best_offense' do
    expect(@game_team.best_offense).to eq '6'
  end

  it '#worst_offense' do
    expect(@game_team.worst_offense).to eq '3'
  end

  it '#total_goals_by_team' do
    result = { '3' => 1.6666666666666667, '6' => 3.3333333333333335 }

    expect(@game_team.total_goals_by_team).to eq result
  end

  it '#highest_scoring_visitor' do
    expect(@game_team.highest_scoring_visitor).to eq '3'
  end

  it '#highest_scoring_home_team' do
    expect(@game_team.highest_scoring_home_team).to eq '6'
  end

  it '#hoa_goals' do
    away_result = { '3' => 4, '6' => 2 }
    home_result = { '3' => 1, '6' => 8 }

    expect(@game_team.hoa_goals('away')).to eq away_result
    expect(@game_team.hoa_goals('home')).to eq home_result
  end

  it '#games_count_by_team' do
    result = { '3' => 3.0, '6' => 3.0 }

    expect(@game_team.games_count_by_team).to eq result
  end

  it '#average' do
    away = { '3' => 4, '6' => 5 }
    home = { '3' => 1, '6' => 8 }

    expect(@game_team.average(away, 'max')).to eq '6'
    expect(@game_team.average(home, 'max')).to eq '6'
  end

  it '#lowest_scoring_visitor' do
    expect(@game_team.lowest_scoring_visitor).to eq '6'
  end

  it '#lowest_scoring_home_team' do
    expect(@game_team.lowest_scoring_home_team).to eq '3'
  end

  it '#winningest_team' do
    expect(@game_team.winningest_team).to eq '6'
  end

  it '#win_count' do
    result = { '6' => 3 }

    expect(@game_team.win_count).to eq result
  end

  it '#best_fans' do
    expect(@game_team.best_fans).to eq '6'
  end

  it '#home_away_difference' do
    result = { '6' =>
                { 'away' => 0.3333333333333333, 'home' => 0.6666666666666666 } }

    expect(@game_team.home_away_difference).to eq result
  end

  it '#group_by_hoa' do
    teams = { '6' =>
      [game_id: '2012030221', team_id: '6', hoa: 'home', goals: '3'] }

    result = { '6' => { 'home' => 1 } }

    expect(@game_team.group_by_hoa(teams)).to eq result
  end

  it '#value_count' do
    teams = { '6' => { 'home' => %w[row row], 'away' => ['row'] } }

    result = { '6' => { 'away' => 1, 'home' => 2 } }

    expect(@game_team.value_count(teams)).to eq result
  end

  it '#worst_fans' do
    expect(@game_team.worst_fans).to eq []
  end

  it '#best_defense' do
    expect(@game_team.best_defense).to eq '6'
  end

  it '#worst_defense' do
    expect(@game_team.worst_defense).to eq '3'
  end

  it '#goals_allowed' do
    goals = {}
    index_one = { team_id: '6', hoa: 'home', won: 'TRUE', goals: '3' }
    index_two = { team_id: '3', hoa: 'away', won: 'FALSE', goals: '2' }

    expect(@game_team.goals_allowed(goals, index_one, index_two)).to eq 2
  end

  it '#goals_switch' do
    goals = {}
    game = ['2012030221',
      [{ game_id: '2012030221', team_id: '3', hoa: 'away', won: 'FALSE', goals: '2' },
      { game_id: '2012030221', team_id: '6', hoa: 'home', won: 'TRUE', goals: '3' }]]
    result = { '6' => 2, '3' => 3 }

    expect(@game_team.goals_switch(game, goals)).to eq [0, 1]
    expect(goals).to eq result
  end

  it '#ga_calculation' do
    result = { '6' => 5, '3' => 10 }

    expect(@game_team.ga_calculation).to eq result
  end

  it '#game_per_team' do
    expect(@game_team.game_per_team('3')).to be_an_instance_of Array
    expect(@game_team.game_per_team('3').count).to eq 3
  end

  it '#average_win_percentage' do
    expect(@game_team.average_win_percentage('6')).to eq 1.0
  end

  it '#most_goals_scored' do
    expect(@game_team.most_goals_scored('6')).to eq 5
  end

  it '#fewest_goals_scored' do
    expect(@game_team.fewest_goals_scored('6')).to eq 2
  end

  it '#favorite_opponent' do
    expect(@game_team.favorite_opponent('6')).to eq '3'
  end

  it '#rival' do
    expect(@game_team.rival('6')).to eq '3'
  end

  it '#biggest_team_blowout' do
    expect(@game_team.biggest_team_blowout('6')).to eq 3
  end

  it '#worst_loss' do
    expect(@game_team.worst_loss('3')).to eq 3
  end
end
