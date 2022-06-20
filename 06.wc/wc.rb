#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
TEMP_FILE = '.tmp_wc'
WIDTH = 5

def main(params, path)
  if path == TEMP_FILE
    File.open(path, 'w+') do |tmp_file|
      readlines.each { |line| tmp_file.write line }
    end
  end

  File.open(path) do |file|
    file_name = path == TEMP_FILE ? '' : path.split('/')[-1]
    file_body = file.read
    file_size = file.size
    n_lines = file_body.count("\n")
    n_lines += 1 if /[^\n]\z/.match?(file_body)
    n_words = file_body.scan(/[!-~]+/).size

    printf("%#{WIDTH}d ", n_lines)
    printf("%#{WIDTH}d %#{WIDTH}d ", n_words, file_size, file_name) unless params[:lines]
    printf("%s\n", file_name)
    [n_lines, n_words, file_size]
  end
end

# コマンドの引数を取得
def read_option
  params = {}
  opt = OptionParser.new
  opt.on('-l', '--lines') { |v| params[:lines] = v }
  opt.parse!(ARGV)
  params
end

params = read_option

has_path = ARGV[0].nil? ? [TEMP_FILE] : ARGV.each { |file| File.absolute_path(file) }

total = has_path.map { |file| main(params, file) }
unless has_path[1].nil?
  total.transpose.map(&:sum).each { |value| printf("%#{WIDTH}d ", value) }
  puts('total')
end
