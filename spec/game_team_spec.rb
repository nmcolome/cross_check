require './spec/spec_helper.rb'
require './lib/game_team.rb'

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
end