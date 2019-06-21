require 'erb'

@fruits = %w(apple orange banana)
@name = 'Natalia'
template = File.open("test.erb").read
erb = ERB.new(template, nil, '>')
a = File.new('test.html', 'w+')
a.puts(erb.result(binding))
# puts 