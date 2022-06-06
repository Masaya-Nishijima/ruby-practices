# frozen_string_literal: true

MAX_FRAME = 10
class Game
  attr_reader :score_board

  def initialize(game_result)
    @score_board = slice_result(game_result)

    @frames = []
    @score_board.each do |frame_score|
      @frames << Frame.new(frame_score)
    end
  end

  def score
    base_score = @frames.map(&:point).sum

    base_score + calc_strike_score + calc_spare_score
  end

  private

  def slice_result(result)
    answer = []
    result_array = result.split(',').map do |result_shot|
      result_shot == 'X' ? 'X' : result_shot.to_i
    end
    (MAX_FRAME - 1).times do
      answer << if result_array[0] == 'X'
                  result_array.shift(1)
                else
                  result_array.shift(2)
                end
    end
    answer << result_array
  end

  def calc_strike_score
    strike_score = 0
    @frames.each_with_index do |frame, index|
      next if index == MAX_FRAME - 1

      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]
      if frame.status == 'STRIKE'
        if next_frame.status == 'STRIKE'
          strike_score += next_frame.point
          strike_score += after_next_frame.first_shot.point if index != MAX_FRAME - 2
        else
          strike_score += index == 8 ? next_frame.first_shot.point + next_frame.second_shot.point : next_frame.point
        end
      end
    end
    strike_score
  end

  def calc_spare_score
    spare_score = 0
    @frames.each_with_index do |frame, index|
      next if index == MAX_FRAME - 1

      next_frame = @frames[index + 1]
      spare_score += next_frame.first_shot.point if frame.status == 'SPARE'
    end
    spare_score
  end
end
