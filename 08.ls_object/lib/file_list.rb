# frozen_string_literal: true

require './lib/file'
class FileList
  LINE_DISPLAY_COUNT = 3
  def initialize(argument)
    @argument = argument
    path = @argument.path
    has_all = @argument.all? ? File::FNM_DOTMATCH : 0
    has_path = @argument.path.nil? ? Dir.getwd : File.absolute_path(@argument.path)
    @files = Dir.glob('*', has_all, base: has_path).sort.map { |file| File.new("#{has_path}/#{file}") }
    @files[0] = File.new(path) if @files == []

    @files.reverse! if @argument.reverse?
  end

  def print_ls
    @argument.long? ? print_long : print_short
  end

  private

  def print_short
    @display_width = [@files.map { |file| file.name.length }.max + 7, 24].max
    names = sort_array(@files.map(&:name))
    names.size.times do |time|
      names[time].size.times do |column|
        printf('%-*s', @display_width, names[time][column])
      end
      puts
    end
  end

  def sort_array(array)
    height = (array.size.to_f / LINE_DISPLAY_COUNT).ceil
    answer_array = []

    if array.size <= LINE_DISPLAY_COUNT
      answer_array[0] = array
      return answer_array
    end

    array = array.each_slice(height).to_a
    array.size.times do |row|
      (array[0].size - array[row].size).times { array[row] << nil }
    end
    array.transpose
  end

  # long用↓
  def print_long
    puts("total\s#{@files.map { |file| (file.size / 512.to_f).ceil }.sum}") unless @files[1].nil?
    @files.map do |file|
      print("#{file.type}#{file.mode_rwx_owner}#{file.mode_rwx_group}#{file.mode_rwx_other}\s\s#{file.n_link.to_s.rjust(widthes[:link])}\s")
      print("#{file.owner.rjust(widthes[:owner])}\s\s#{file.group.rjust(widthes[:group])}\s\s#{file.size.to_s.rjust(widthes[:size])}\s")
      puts("#{file.time_for_ls}\s #{file.name}")
    end
  end

  def widthes
    widthes = {}
    widthes[:link] = @files.map(&:n_link).max.to_s.length
    widthes[:owner] = @files.map { |file| file.owner.length }.max
    widthes[:group] = @files.map { |file| file.group.length }.max
    widthes[:size] = @files.map(&:size).max.to_s.length
    widthes
  end
end
