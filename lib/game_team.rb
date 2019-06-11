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
    total_goals_by_team.max_by { |key,value| value }[0]
  end

  def worst_offense
    total_goals_by_team.min_by { |key,value| value }[0]
  end

  def total_goals_by_team
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      total = goals.inject(&:+)
      goals_by_team[key] = total/ goals.count.to_f
    end
  end

  def highest_scoring_visitor
    away = @content.group_by {|row| row[:hoa] == 'away' }[true]
    goals_by_team = @content.group_by { |row| row[:team_id] }
    goals_by_team.each do |key, value|
      goals_by_team[key] = value.count.to_f
    end
    goals_by_visitor = away.group_by { |row| row[:team_id] }
    goals_by_visitor.each do |key, value|
      goals = value.map { |row| row[:goals].to_i }
      goals_by_visitor[key] = goals.inject(&:+)
    end
    goals_by_visitor.each do |key, value|
      goals_by_visitor[key] = value/goals_by_team[key]
    end
    goals_by_visitor.max_by { |key,value| value }[0]
  end
end
