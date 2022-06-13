# frozen_string_literal: true

require './lib/shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(shots)
    @first_shot, @second_shot = @shots = shots.map { |shot| Shot.new(shot) }
  end

  def point
    @shots.map(&:point).sum
  end

  def status
    return unless @shots[2].nil?
    return 'STRIKE' if @first_shot.point == 10
    return 'SPARE' if @shots.slice(0, 2).map(&:point).sum == 10
  end
end
