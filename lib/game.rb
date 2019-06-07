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
end
