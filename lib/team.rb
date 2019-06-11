require 'CSV'

class Team
  attr_reader :content

  def initialize
    @content = []
  end

  def to_data(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @content << row
    end
  end

  def count_of_teams
    @content.count
  end

  def find_name(team_id)
    result = @content.find { |row| row[:team_id] == team_id }
    result[:teamname]
  end
end
