MAX_FRAME = 10
class Game
  attr_reader :score_board
  def initialize(game_result)
    @score_board = slice_result(game_result)

    @frames = []
    @score_board.each { |frame_score|
      @frames << Frame.new(frame_score)
    }
  end

  def slice_result(result)
    answer = []
    result_array = result.split(',').map { |result_shot|
      result_shot == 'X' ? 'X' : result_shot.to_i
    }
    (MAX_FRAME - 1).times do
      if result_array[0] == 'X'
        answer << result_array.shift(1)
      else
        answer << result_array.shift(2)
      end
    end
    answer << result_array
  end

  def score
    score = @frames.map(&:point).sum

    @frames.each_with_index{ |frame, index|
      next if index == MAX_FRAME - 1
      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]
      if frame.status == 'SPARE'
        score += next_frame.first_shot.point
      end
      if frame.status == 'STRIKE'
        if next_frame.status == "STRIKE"
          score += next_frame.first_shot.point
          score += after_next_frame.first_shot.point
        else
          score += next_frame.point
        end
      end
    }

    score
  end
end
