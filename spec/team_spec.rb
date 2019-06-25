require './spec/spec_helper.rb'
require './lib/team.rb'

RSpec.describe Team do
  before(:all) do
    @team_fixture = './data/team_info.csv'

    @team = Team.new
  end

  it 'exists' do
    expect(@team).to be_an_instance_of Team
  end

  it 'has @content' do
    expect(@team.content).to eq []
  end

  it '#to_data adds content based on csv' do
    @team.to_data(@team_fixture)
    expect(@team.content).to be_an_instance_of Array
    expect(@team.content[0][:team_id]).to eq '1'
  end

  it '#count_of_teams' do
    expect(@team.count_of_teams).to eq 33
  end

  it '#find_name' do
    expect(@team.find_name('1')).to eq 'Devils'
    expect(@team.find_name('14')).to eq 'Lightning'
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

    expect(@team.team_info('1')).to eq result
  end

  it '#teams' do
  expect(@team.teams).to be_an_instance_of Array
  expect(@team.teams.count).to eq 33
  expect(@team.teams[0]).to eq ['Anaheim Ducks', '24']
  expect(@team.teams[32]).to eq ['Winnipeg Jets', '52']
  end
end
