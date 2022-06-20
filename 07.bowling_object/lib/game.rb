# frozen_string_literal: true

require './lib/frame'

MAX_FRAME = 10
class Game
  def initialize(game_result)
    score_board = slice_result(game_result)

    @frames = score_board.map { |frame_score| Frame.new(frame_score) }
  end

  def score
    base_score = @frames.map(&:point).sum

    base_score + calc_strike_score + calc_spare_score
  end

  private

  def slice_result(result)
    answer = []
    results = result.split(',').map do |result_shot|
      result_shot == 'X' ? 'X' : result_shot.to_i
    end

    (MAX_FRAME - 1).times { answer << results.shift(results[0] == 'X' ? 1 : 2) }
    answer << results
  end

  def calc_strike_score
    @frames.each_with_index.sum do |frame, index|
      next 0 if frame.status != 'STRIKE' || index == MAX_FRAME - 1

      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]

      if next_frame.status == 'STRIKE'
        next_frame.point + (index != MAX_FRAME - 2 ? after_next_frame.first_shot.point : 0)
      else
        index == 8 ? next_frame.first_shot.point + next_frame.second_shot.point : next_frame.point
      end
    end
  end

  def calc_spare_score
    @frames.each_with_index.sum do |frame, index|
      next 0 if frame.status != 'SPARE' || index == MAX_FRAME - 1

      next_frame = @frames[index + 1]
      next_frame.first_shot.point
    end
  end
end
