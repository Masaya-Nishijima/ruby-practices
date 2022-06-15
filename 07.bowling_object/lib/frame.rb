# frozen_string_literal: true

require './lib/shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(shots)
    @first_shot, @second_shot, @third_shot = shots.map { |shot| Shot.new(shot) }
  end

  def point
    [@first_shot, @second_shot, @third_shot].compact.map(&:point).sum
  end

  def status
    return unless @third_shot.nil?
    return 'STRIKE' if @first_shot.point == 10
    return 'SPARE' if [@first_shot, @second_shot].map(&:point).sum == 10
  end
end
