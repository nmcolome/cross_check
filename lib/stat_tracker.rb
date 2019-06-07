require 'CSV'

class StatTracker
  attr_reader :content

  def initialize
    @content = {}
  end

  def from_csv(files)
    files.each do |title, file|
      @content[title] = []
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        @content[title] << row
      end
    end
  end
end
