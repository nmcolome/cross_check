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
    expect(@game_team.content.count).to eq 7
    expect(@game_team.content[0][:game_id]).to eq '2012030221'
  end

  it '#best_offense' do
    expect(@game_team.best_offense).to eq '6'
  end

  it '#worst_offense' do
    expect(@game_team.worst_offense).to eq '3'
  end

  it '#total_goals_by_team' do
    result = {
              '3'=>1.6666666666666667,
              '6'=>3.25
             }

    expect(@game_team.total_goals_by_team).to eq result
  end

  # it '#best_defense' do
  #   expect(@game_team.best_defense).to eq '3'
  # end

  it '#highest_scoring_visitor' do
    expect(@game_team.highest_scoring_visitor).to eq '3'
  end

  it '#highest_scoring_home_team' do
    expect(@game_team.highest_scoring_home_team).to eq '6'
  end

  it '#hoa_goals' do
    away_result = {'3'=>4, '6'=>5}
    home_result = {'3'=>1, '6'=>8}

    expect(@game_team.hoa_goals('away')).to eq away_result
    expect(@game_team.hoa_goals('home')).to eq home_result
  end

  it '#games_count_by_team' do
    result = {'3'=>3.0, '6'=>4.0}

    expect(@game_team.games_count_by_team).to eq result
  end

  it '#average' do
    away = {'3'=>4, '6'=>5}
    home = {'3'=>1, '6'=>8}

    expect(@game_team.average(away, 'max')).to eq '3'
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
    result = { "6" => 3 }

    expect(@game_team.win_count).to eq result
  end

  it '#best_fans' do
    expect(@game_team.best_fans).to eq '6'
  end

  it '#home_away_difference' do
    result = {"6"=>{"away"=>0.25, "home"=>0.5}}

    expect(@game_team.home_away_difference).to eq result
  end

  it '#group_by_hoa' do
    teams = {"6"=>
      [game_id:"2012030221", team_id:"6", hoa:"home", won:"TRUE", settled_in:"OT", head_coach:"Claude Julien", goals:"3"]}

    result = {"6"=>{"home"=>1}}

    expect(@game_team.group_by_hoa(teams)).to eq result
  end

  it '#value_count' do
    teams = { "6" => {
                      "home" => ['row', 'row'],
                      "away"=> ['row']
                      }
            }

    result = {"6"=>{"away"=>1, "home"=>2}}

    expect(@game_team.value_count(teams)).to eq result
  end

  it '#percentage_wins' do
    teams = {"6"=>{"away"=>1, "home"=>2}}
    game_count = {"6"=>4.0}
    result = {"6"=>{"away"=>0.25, "home"=>0.5}}

    expect(@game_team.percentage_wins(teams, game_count)).to eq result
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
end