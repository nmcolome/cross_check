require './spec/spec_helper.rb'
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
    expect(@game.content.count).to eq 9
    expect(@game.content[0][:game_id]).to eq '2012030221'
  end

  it '#highest_total_score' do
    expect(@game.highest_total_score).to eq 9
  end

  it '#lowest_total_score' do
    expect(@game.lowest_total_score).to eq 3
  end

  it '#biggest_blowout' do
    expect(@game.biggest_blowout).to eq 5
  end

  it '#percentage_home_wins' do
    expect(@game.percentage_home_wins).to eq 0.78
  end

  it '#percentage_visitor_wins' do
    expect(@game.percentage_visitor_wins).to eq 0.22
  end

  it '#count_of_games_by_season' do
    result = {
      '20122013' => 6,
      '20132014' => 3
    }

    expect(@game.count_of_games_by_season).to eq result
  end

  it '#average_goals_per_game' do
    expect(@game.average_goals_per_game).to eq 5.33
  end

  it '#average_goals_by_season' do
    result = {
      '20122013' => 5.0,
      '20132014' => 6.0
    }

    expect(@game.average_goals_by_season).to eq result
  end

  it '#best_season' do
    expect(@game.best_season('3')).to eq '20122013'
  end
end
