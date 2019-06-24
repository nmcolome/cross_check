require 'erb'
require './lib/runner'

class PageGenerator
  def initialize
    @stat_tracker = Runner.new.start
    @teams = @stat_tracker.teams
    @layout = File.read('./site/layout.erb')
    @template = File.read('./site/index_template.erb')
  end

  def render
    templates = [@template, @layout]
    templates.inject(nil) do | prev, temp |
      _render(temp) { prev }
    end
  end

  def _render(temp)
    ERB.new(temp, nil, '>').result(binding)
  end
end

output = PageGenerator.new
a = File.new('./site/index.html', 'w+')
a.puts(output.render)