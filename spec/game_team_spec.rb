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

  it '#biggest_bust' do
    games = {
      'P' => %w[2013030111 2013030112 2013030113 2013030114 2013030115 2013030211 2013030212 2013030213 2013030214 2013030215 2013030216 2013030217],
      'R' => %w[2013020007 2013020021 2013020048 2013020068 2013020079 2013020103 2013020114 2013020138 2013020139 2013020155 2013020184 2013020188 2013020204 2013020217 2013020230 2013020247 2013020262 2013020277 2013020289 2013020309 2013020317 2013020326 2013020341 2013020355 2013020370 2013020380 2013020393 2013020425 2013020438 2013020450 2013020467 2013020482 2013020498 2013020509 2013020523 2013020541 2013020562 2013020567 2013020577 2013020602 2013020612 2013020626 2013020655 2013020667 2013020684 2013020696 2013020717 2013020736 2013020739 2013020776 2013020789 2013020795 2013020809 2013020824 2013020844 2013020864 2013020874 2013020882 2013020902 2013020916 2013020924 2013020938 2013020956 2013020963 2013020985 2013020989 2013021004 2013021022 2013021026 2013021053 2013021063 2013021075 2013021092 2013021108 2013021121 2013021141 2013021144 2013021160 2013021187 2013021202 2013021212 2013021221]
    }

    expect(@game_team.biggest_bust(games)).to eq '17'
  end

  it '#biggest_surprise' do
    games = {
      'P' => %w[2013030111 2013030112 2013030113 2013030114 2013030115 2013030211 2013030212 2013030213 2013030214 2013030215 2013030216 2013030217],
      'R' => %w[2013020007 2013020021 2013020048 2013020068 2013020079 2013020103 2013020114 2013020138 2013020139 2013020155 2013020184 2013020188 2013020204 2013020217 2013020230 2013020247 2013020262 2013020277 2013020289 2013020309 2013020317 2013020326 2013020341 2013020355 2013020370 2013020380 2013020393 2013020425 2013020438 2013020450 2013020467 2013020482 2013020498 2013020509 2013020523 2013020541 2013020562 2013020567 2013020577 2013020602 2013020612 2013020626 2013020655 2013020667 2013020684 2013020696 2013020717 2013020736 2013020739 2013020776 2013020789 2013020795 2013020809 2013020824 2013020844 2013020864 2013020874 2013020882 2013020902 2013020916 2013020924 2013020938 2013020956 2013020963 2013020985 2013020989 2013021004 2013021022 2013021026 2013021053 2013021063 2013021075 2013021092 2013021108 2013021121 2013021141 2013021144 2013021160 2013021187 2013021202 2013021212 2013021221]
    }

    expect(@game_team.biggest_surprise(games)).to eq '6'
  end

  it '#winningest_coach' do
    game_ids = %w[2013030111 2013030112 2013030113 2013030114 2013030115 2013030211 2013030212 2013030213 2013030214 2013030215 2013030216 2013030217 2013020007 2013020021 2013020048 2013020068 2013020079 2013020103 2013020114 2013020138 2013020139 2013020155 2013020184 2013020188 2013020204 2013020217 2013020230 2013020247 2013020262 2013020277 2013020289 2013020309 2013020317 2013020326 2013020341 2013020355 2013020370 2013020380 2013020393 2013020425 2013020438 2013020450 2013020467 2013020482 2013020498 2013020509 2013020523 2013020541 2013020562 2013020567 2013020577 2013020602 2013020612 2013020626 2013020655 2013020667 2013020684 2013020696 2013020717 2013020736 2013020739 2013020776 2013020789 2013020795 2013020809 2013020824 2013020844 2013020864 2013020874 2013020882 2013020902 2013020916 2013020924 2013020938 2013020956 2013020963 2013020985 2013020989 2013021004 2013021022 2013021026 2013021053 2013021063 2013021075 2013021092 2013021108 2013021121 2013021141 2013021144 2013021160 2013021187 2013021202 2013021212 2013021221]

    expect(@game_team.winningest_coach(game_ids)).to eq 'Ken Hitchcock'
  end

  it '#worst_coach' do
    game_ids = %w[2013030111 2013030112 2013030113 2013030114 2013030115 2013030211 2013030212 2013030213 2013030214 2013030215 2013030216 2013030217 2013020007 2013020021 2013020048 2013020068 2013020079 2013020103 2013020114 2013020138 2013020139 2013020155 2013020184 2013020188 2013020204 2013020217 2013020230 2013020247 2013020262 2013020277 2013020289 2013020309 2013020317 2013020326 2013020341 2013020355 2013020370 2013020380 2013020393 2013020425 2013020438 2013020450 2013020467 2013020482 2013020498 2013020509 2013020523 2013020541 2013020562 2013020567 2013020577 2013020602 2013020612 2013020626 2013020655 2013020667 2013020684 2013020696 2013020717 2013020736 2013020739 2013020776 2013020789 2013020795 2013020809 2013020824 2013020844 2013020864 2013020874 2013020882 2013020902 2013020916 2013020924 2013020938 2013020956 2013020963 2013020985 2013020989 2013021004 2013021022 2013021026 2013021053 2013021063 2013021075 2013021092 2013021108 2013021121 2013021141 2013021144 2013021160 2013021187 2013021202 2013021212 2013021221]

    expect(@game_team.worst_coach(game_ids)).to eq 'Jon Cooper'
  end
end
