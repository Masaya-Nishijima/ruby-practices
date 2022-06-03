MAX_FRAME = 10
class Game
  attr_reader :score_board
  def initialize(game_result)
    @score_board = slice_result(game_result)
  end

  def slice_result(result)
    answer = []
    result_array = result.split(',').map { |result_shot|
      result_shot == 'X' ? 'X' : result_shot.to_i
    }
    (MAX_FRAME - 1).times do
      result_array.insert(1, nil) if result_array[0] == 'X' 
      answer << result_array.shift(2)
    end
    answer << result_array
  end
end
