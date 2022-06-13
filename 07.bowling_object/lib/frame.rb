# frozen_string_literal: true
require './lib/shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(shots)
    @shots = shots.map { |shot| Shot.new(shot) }
    @first_shot = @shots[0]
    @second_shot = @shots[1]
  end

  def point
    @shots.map(&:point).sum
  end

  def status
    if @shots[2].nil?
      return 'STRIKE' if @first_shot.point == 10
      return 'SPARE' if @shots.slice(0, 2).map(&:point).sum == 10
    end
  end
end
