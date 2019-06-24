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

  def team_info(team_id)
    result = @content.find { |row| row[:team_id] == team_id }
    {
      'team_id' => result[:team_id],
      'franchise_id' => result[:franchiseid],
      'short_name' => result[:shortname],
      'team_name' => result[:teamname],
      'abbreviation' => result[:abbreviation],
      'link' => result[:link]
    }
  end

  def teams
    @content.map { |r| ["#{r[:shortname]} #{r[:teamname]}", r[:team_id]] }.sort
  end
end
