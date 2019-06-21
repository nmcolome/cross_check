require 'erb'

@fruits = %w(apple orange banana)
@name = 'Natalia'
erb = ERB.new(File.open("test.erb").read)
a = File.new('test.html', 'w+')
a.puts(erb.result(binding))
# puts 