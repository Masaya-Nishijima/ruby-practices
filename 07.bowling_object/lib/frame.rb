class Frame
  attr_reader :first_shot, :second_shot
  def initialize(shots)
    @shots = []
    shots.each do |shot|
      @shots.push Shot.new(shot)
    end
    @first_shot = @shots[0]
    @second_shot = @shots[1]
  end

  def point
    @shots.map(&:point).sum
  end

  def status
    return 'THREE_SHOT' if !@shots[2].nil?
    return 'STRIKE' if @shots[0].point == 10
    return 'SPARE' if @shots.slice(0, 2).map(&:point).sum == 10
  end
end