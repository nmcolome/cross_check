require 'CSV'

class Game
  attr_reader :content

  def initialize
    @content = []
  end

  def to_data(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @content << row
    end
  end

  def scores_sum
    @content.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }
  end

  def highest_total_score
    scores_sum.max
  end

  def lowest_total_score
    scores_sum.min
  end

  def biggest_blowout
    diff = @content.map { |row| (row[:home_goals].to_i - row[:away_goals].to_i).abs }
    diff.max
  end

  def percentage_home_wins
    home = @content.count { |row| row[:outcome].split(' ')[0] == "home" }
    (home.to_f / @content.count).round(2)
  end

  def percentage_visitor_wins
    away = @content.count { |row| row[:outcome].split(' ')[0] == "away" }
    (away.to_f / @content.count).round(2)
  end

  def count_of_games_by_season
    groups = @content.group_by {|row| row[:season]}
    result = {}
    groups.each {|key, value| result[key] = value.count }
    result
  end

  def average_goals_per_game
    average_goals(@content)
  end

  def average_goals_by_season
    groups = @content.group_by {|row| row[:season]}
    result = {}

    groups.each {|key, value| result[key] = average_goals(value) }
    result
  end

  def average_goals(rows)
    goals = rows.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }
    (goals.inject(:+) / goals.count.to_f).round(2)
  end
end
