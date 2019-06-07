require './test/test_helper.rb'
require './lib/game.rb'

RSpec.describe Game do
  before(:all) do
    @game_fixture = './data/game_fixture.csv'

    @game = Game.new
  end

  it 'exists' do
    expect(@game).to be_an_instance_of Game
  end

  it 'has @content' do
    expect(@game.content).to eq []
  end

  it '#to_data adds content based on csv' do
    @game.to_data(@game_fixture)
    expect(@game.content).to be_an_instance_of Array
    expect(@game.content.count).to eq 4
    expect(@game.content[0][:game_id]).to eq '2012030221'
  end
end