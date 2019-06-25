require './lib/stat_tracker'

class Runner
  def initialize
    @game_path = './data/game.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats.csv'
  end

  def locations
    {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  end

  def start
    StatTracker.from_csv(locations)
  end
end
