require './spec/spec_helper.rb'
require './lib/game_team.rb'
require 'pry'

RSpec.describe GameTeam do
  before(:all) do
    @game_team_fixture = './data/game_teams_for_6.csv'

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
    expect(@game_team.content.count).to eq 1020
    expect(@game_team.content[0][:game_id]).to eq '2012020004'
  end

  it '#best_offense' do
    expect(@game_team.best_offense).to eq '24'
  end

  it '#worst_offense' do
    expect(@game_team.worst_offense).to eq '53'
  end

  it '#highest_scoring_visitor' do
    expect(@game_team.highest_scoring_visitor).to eq '24'
  end

  it '#highest_scoring_home_team' do
    expect(@game_team.highest_scoring_home_team).to eq '24'
  end

  it '#lowest_scoring_visitor' do
    expect(@game_team.lowest_scoring_visitor).to eq '53'
  end

  it '#lowest_scoring_home_team' do
    expect(@game_team.lowest_scoring_home_team).to eq '30'
  end

  it '#winningest_team' do
    expect(@game_team.winningest_team).to eq '24'
  end

  it '#best_fans' do
    expect(@game_team.best_fans).to eq '54'
  end

  it '#worst_fans' do
    result = %w[7 8 2 9 21 25]
    expect(@game_team.worst_fans).to eq result
  end

  it '#best_defense' do
    expect(@game_team.best_defense).to eq '54'
  end

  it '#worst_defense' do
    expect(@game_team.worst_defense).to eq '53'
  end

  it '#game_per_team' do
    expect(@game_team.game_per_team('6')).to be_an_instance_of Array
    expect(@game_team.game_per_team('6').count).to eq 510
  end

  it '#average_win_percentage' do
    expect(@game_team.average_win_percentage('6')).to eq 0.56
  end

  it '#most_goals_scored' do
    expect(@game_team.most_goals_scored('6')).to eq 8
  end

  it '#fewest_goals_scored' do
    expect(@game_team.fewest_goals_scored('6')).to eq 0
  end

  it '#favorite_opponent' do
    expect(@game_team.favorite_opponent('6')).to eq '27'
  end

  it '#rival' do
    expect(@game_team.rival('6')).to eq '24'
  end

  it '#biggest_team_blowout' do
    expect(@game_team.biggest_team_blowout('6')).to eq 6
  end

  it '#worst_loss' do
    expect(@game_team.worst_loss('6')).to eq 7
  end
end
