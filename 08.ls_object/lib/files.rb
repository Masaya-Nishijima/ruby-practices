# frozen_string_literal: true

require 'etc'
require './lib/long'

class Files
  include LongFormat
  WIDTH = 3

  def initialize(path = nil, all = nil)
    has_all = all.nil? ? 0 : File::FNM_DOTMATCH
    @has_path = path.nil? ? Dir.getwd : File.absolute_path(path)
    @files = Dir.glob('*', has_all, base: @has_path).sort
    if @files == []
      @files[0] = path
      @has_path.sub!(/[.a-zA-Z0-9]+$/, '')
    end
    @display_width = [@files.map(&:length).max + 7, 24].max
  end

  def print_short_format
    files = sort_array(@files)
    files.size.times do |time|
      files[time].size.times do |column|
        printf('%-*s', @display_width, files[time][column])
      end
      puts
    end
  end

  def reverse!
    @files.reverse!
  end

  private

  def sort_array(array)
    height = (array.size.to_f / WIDTH).ceil
    answer_array = []

    if array.size <= WIDTH
      answer_array[0] = array
      return answer_array
    end

    array = array.each_slice(height).to_a
    array.size.times do |row|
      (array[0].size - array[row].size).times { array[row] << nil }
    end
    array.transpose
  end
end
