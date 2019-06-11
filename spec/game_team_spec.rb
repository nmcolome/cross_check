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

    expect(@game_team.average(away)).to eq '3'
    expect(@game_team.average(home)).to eq '6'
  end
end