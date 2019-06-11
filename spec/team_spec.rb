require './spec/spec_helper.rb'
require './lib/team.rb'

RSpec.describe Team do
  before(:all) do
    @team_fixture = './data/team_fixture.csv'

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
    expect(@team.content.count).to eq 5
    expect(@team.content[0][:team_id]).to eq '1'
  end
end