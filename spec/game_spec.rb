require './spec/test_helper.rb'
require './lib/game.rb'
require 'pry'

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

  it '#highest_total_score' do
    expect(@game.highest_total_score).to eq 7
  end

  it '#lowest_total_score' do
    expect(@game.lowest_total_score).to eq 3
  end

  it '#biggest_blowout' do
    expect(@game.biggest_blowout).to eq 3
  end

  it '#percentage_home_wins' do
    expect(@game.percentage_home_wins).to eq 0.75
  end

  it '#percentage_visitor_wins' do
    expect(@game.percentage_visitor_wins).to eq 0.25
  end
end
