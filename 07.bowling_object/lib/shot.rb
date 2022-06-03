class Shot
  attr_reader :point
  def initialize(shot_score)
    if shot_score == 'X'
      @point = 10
    else
      @point = shot_score
    end
  end
end
