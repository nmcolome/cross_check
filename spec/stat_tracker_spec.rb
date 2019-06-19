require './spec/spec_helper.rb'
require './lib/stat_tracker.rb'
require 'pry'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/game_for_6.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_for_6.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '::from_csv' do
    expect(@stat_tracker.game.content.count).to eq 510
    expect(@stat_tracker.team.content.count).to eq 33
    expect(@stat_tracker.game_team.content.count).to eq 1020
  end

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq 12
  end

  it '#lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end

  it '#biggest_blowout' do
    expect(@stat_tracker.biggest_blowout).to eq 7
  end

  it '#percentage_home_wins' do
    expect(@stat_tracker.percentage_home_wins).to eq 0.54
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.46
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

    expect(@stat_tracker.count_of_games_by_season).to eq result
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq 5.44
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

    expect(@stat_tracker.average_goals_by_season).to eq result
  end

  it '#count_of_teams' do
    expect(@stat_tracker.count_of_teams).to eq 33
  end

  it '#best_offense' do
    expect(@stat_tracker.best_offense).to eq 'Ducks'
  end

  it '#worst_offense' do
    expect(@stat_tracker.worst_offense).to eq 'Coyotes'
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq 'Ducks'
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq 'Ducks'
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq 'Coyotes'
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq 'Wild'
  end

  it '#winningest_team' do
    expect(@stat_tracker.winningest_team).to eq 'Ducks'
  end

  it '#best_fans' do
    expect(@stat_tracker.best_fans).to eq 'Golden Knights'
  end

  it '#worst_fans' do
    result = %w[Sabres Canadiens Islanders Senators Avalanche Stars]

    expect(@stat_tracker.worst_fans).to eq result
  end

  it '#best_defense' do
    expect(@stat_tracker.best_defense).to eq 'Golden Knights'
  end

  it '#worst_defense' do
    expect(@stat_tracker.worst_defense).to eq 'Coyotes'
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

    expect(@stat_tracker.team_info('1')).to eq result
  end

  it '#best_season' do
    expect(@stat_tracker.best_season('6')).to eq '20132014'
  end

  it '#worst_season' do
    expect(@stat_tracker.worst_season('6')).to eq '20142015'
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage('6')).to eq 0.56
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored('6')).to eq 8
  end

  it '#fewest_goals_scored' do
    expect(@stat_tracker.fewest_goals_scored('6')).to eq 0
  end

  it '#favorite_opponent' do
    expect(@stat_tracker.favorite_opponent('6')).to eq 'Coyotes'
  end

  it '#rival' do
    expect(@stat_tracker.rival('6')).to eq 'Ducks'
  end

  it '#biggest_team_blowout' do
    expect(@stat_tracker.biggest_team_blowout('6')).to eq 6
  end

  it '#worst_loss' do
    expect(@stat_tracker.worst_loss('6')).to eq 7
  end

  it '#head_to_head' do
    result = {
      'Avalanche' => 0.3,
      'Blackhawks' => 0.44,
      'Blue Jackets' => 0.6,
      'Blues' => 0.4,
      'Canadiens' => 0.41,
      'Canucks' => 0.5,
      'Capitals' => 0.17,
      'Coyotes' => 1.0,
      'Devils' => 0.78,
      'Ducks' => 0.1,
      'Flames' => 0.6,
      'Flyers' => 0.67,
      'Golden Knights' => 0.5,
      'Hurricanes' => 0.67,
      'Islanders' => 0.67,
      'Jets' => 0.62,
      'Kings' => 0.5,
      'Lightning' => 0.66,
      'Maple Leafs' => 0.51,
      'Oilers' => 0.4,
      'Panthers' => 0.76,
      'Penguins' => 0.64,
      'Predators' => 0.5,
      'Rangers' => 0.52,
      'Red Wings' => 0.73,
      'Sabres' => 0.62,
      'Senators' => 0.47,
      'Sharks' => 0.7,
      'Stars' => 0.6,
      'Wild' => 0.6
    }

    expect(@stat_tracker.head_to_head('6')).to eq result
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

    expect(@stat_tracker.seasonal_summary('6')).to eq result
  end

  it '#biggest_bust' do
    expect(@stat_tracker.biggest_bust('20132014')).to eq 'Red Wings'
  end

  it '#biggest_surprise' do
    expect(@stat_tracker.biggest_surprise('20132014')).to eq 'Bruins'
  end

  it '#winningest_coach' do
    expect(@stat_tracker.winningest_coach('20132014')).to eq 'Ken Hitchcock'
  end

  it '#worst_coach' do
    expect(@stat_tracker.worst_coach('20132014')).to eq 'Jon Cooper'
  end
end
