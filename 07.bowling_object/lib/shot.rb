# frozen_string_literal: true

class Shot
  attr_reader :point

  def initialize(shot_score)
    @point = if shot_score == 'X'
               10
             else
               shot_score
             end
  end
end
