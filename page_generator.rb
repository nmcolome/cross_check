require 'erb'
require './lib/runner'
require 'pry'
# require './lib/stat_tracker'

# game_path = './data/game.csv'
# team_path = './data/team_info.csv'
# game_teams_path = './data/game_teams_stats.csv'

# locations = {
#   games: game_path,
#   teams: team_path,
#   game_teams: game_teams_path
# }

# @stat_tracker = StatTracker.from_csv(locations)

@stat_tracker = Runner.new.start
binding.pry
template = File.open("./site/index.erb").read
erb = ERB.new(template, nil, '>')
a = File.new('./site/index.html', 'w+')
a.puts(erb.result(binding))

class PageGenerator
  
end

