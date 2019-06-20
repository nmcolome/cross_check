require './spec/spec_helper.rb'
require './lib/game.rb'
require 'pry'

RSpec.describe Game do
  before(:all) do
    @game_fixture = './data/game_for_6.csv'

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
    expect(@game.content.count).to eq 510
    expect(@game.content[0][:game_id]).to eq '2012020004'
  end

  it '#highest_total_score' do
    expect(@game.highest_total_score).to eq 12
  end

  it '#lowest_total_score' do
    expect(@game.lowest_total_score).to eq 1
  end

  it '#biggest_blowout' do
    expect(@game.biggest_blowout).to eq 7
  end

  it '#percentage_home_wins' do
    expect(@game.percentage_home_wins).to eq 0.54
  end

  it '#percentage_visitor_wins' do
    expect(@game.percentage_visitor_wins).to eq 0.46
  end

  it '#count_of_games_by_season' do
    result = {
      '20122013' => 70,
      '20132014' => 94,
      '20142015' => 82,
      '20152016' => 82,
      '20162017' => 88,
      '20172018' => 94
    }

    expect(@game.count_of_games_by_season).to eq result
  end

  it '#average_goals_per_game' do
    expect(@game.average_goals_per_game).to eq 5.44
  end

  it '#average_goals_by_season' do
    result = {
      '20122013' => 5.03,
      '20132014' => 5.26,
      '20142015' => 5.17,
      '20152016' => 5.73,
      '20162017' => 5.39,
      '20172018' => 5.98
    }

    expect(@game.average_goals_by_season).to eq result
  end

  it '#best_season' do
    input = [
      { game_id: '2012030221', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030222', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030223', team_id: '3', won: 'FALSE', goals: '1' }
    ]

    expect(@game.best_season(input)).to eq '20122013'
  end

  it '#worst_season' do
    input = [
      { game_id: '2012030221', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030222', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030223', team_id: '3', won: 'FALSE', goals: '1' }
    ]

    expect(@game.worst_season(input)).to eq '20122013'
  end

  it '#season_finder' do
    input = [
      { game_id: '2012030221', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030222', team_id: '3', won: 'FALSE', goals: '2' },
      { game_id: '2012030223', team_id: '3', won: 'FALSE', goals: '1' }
    ]
    result = [
      { game_id: '2012030221', won: 'FALSE', season: '20122013' },
      { game_id: '2012030222', won: 'FALSE', season: '20122013' },
      { game_id: '2012030223', won: 'FALSE', season: '20122013' }
    ]

    expect(@game.season_finder(input)).to eq result
  end

  it '#win_percentages' do
    input = [
      { game_id: '2012030221', won: 'FALSE', season: '20122013' },
      { game_id: '2012030222', won: 'FALSE', season: '20122013' },
      { game_id: '2012030223', won: 'FALSE', season: '20122013' }
    ]
    result = { '20122013' => 0.0 }

    expect(@game.win_percentages(input)).to eq result
  end

  it '#seasonal_summary' do
    result = {
      '20122013' => {
        postseason: {
          win_percentage: 0.64,
          total_goals_scored: 65,
          total_goals_against: 47,
          average_goals_scored: 2.95,
          average_goals_against: 2.14
        },
        regular_season: {
          win_percentage: 0.58,
          total_goals_scored: 131,
          total_goals_against: 109,
          average_goals_scored: 2.73,
          average_goals_against: 2.27
        }
      },
      '20132014' => {
        postseason: {
          win_percentage: 0.58,
          total_goals_scored: 30,
          total_goals_against: 26,
          average_goals_scored: 2.5,
          average_goals_against: 2.17
        },
        regular_season: {
          win_percentage: 0.66,
          total_goals_scored: 261,
          total_goals_against: 177,
          average_goals_scored: 3.18,
          average_goals_against: 2.16
        }
      },
      '20142015' => {
        postseason: {
          win_percentage: 0.0,
          total_goals_scored: 0,
          total_goals_against: 0,
          average_goals_scored: 0.0,
          average_goals_against: 0.0
        },
        regular_season: {
          win_percentage: 0.5,
          total_goals_scored: 213,
          total_goals_against: 211,
          average_goals_scored: 2.6,
          average_goals_against: 2.57
        }
      },
      '20152016' => {
        postseason: {
          win_percentage: 0.0,
          total_goals_scored: 0,
          total_goals_against: 0,
          average_goals_scored: 0.0,
          average_goals_against: 0.0
        },
        regular_season: {
          win_percentage: 0.51,
          total_goals_scored: 240,
          total_goals_against: 230,
          average_goals_scored: 2.93,
          average_goals_against: 2.8
        }
      },
      '20162017' => {
        postseason: {
          win_percentage: 0.33,
          total_goals_scored: 13,
          total_goals_against: 15,
          average_goals_scored: 2.17,
          average_goals_against: 2.5
        },
        regular_season: {
          win_percentage: 0.54,
          total_goals_scored: 234,
          total_goals_against: 212,
          average_goals_scored: 2.85,
          average_goals_against: 2.59
        }
      },
      '20172018' => {
        postseason: {
          win_percentage: 0.42,
          total_goals_scored: 41,
          total_goals_against: 37,
          average_goals_scored: 3.42,
          average_goals_against: 3.08
        },
        regular_season: {
          win_percentage: 0.61,
          total_goals_scored: 270,
          total_goals_against: 214,
          average_goals_scored: 3.29,
          average_goals_against: 2.61
        }
      }
    }

    expect(@game.seasonal_summary('6')).to eq result
  end

  it '#by_season_type' do
    result = @game.by_season_type('20132014')

    expect(result['P'].count).to eq 12
    expect(result['R'].count).to eq 82
  end
end
