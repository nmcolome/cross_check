require 'CSV'

class GameTeam
  attr_reader :content

  def initialize
    @content = []
  end

  def to_data(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @content << row
    end
  end

  def best_offense
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      goals_by_team[key] = goals
    end
    goals_by_team.each do |key, value|
      total = value.inject(&:+)
      av = total/ value.count.to_f
      goals_by_team[key] = av
    end
    goals_by_team.max_by { |key,value| value }[0]
  end
end
