require "erb"

class Basicerb
  attr_reader :name

  def initialize name
    @name = name
    @layout = File.read('./layout.html.erb')
    @template = File.read('./test_index.erb')
  end

  def render
    templates = [@template, @layout]
    templates.inject(nil) do | prev, temp |
      _render(temp) { prev }
    end
  end

  def _render temp
    ERB.new(temp).result( binding )
  end
end

erb = Basicerb.new('juan')
# puts erb.render
output = File.new('./test_result.html', 'w+')
output.puts(erb.render)

