#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
TEMP_FILE = '.tmp_wc'
WIDTH = 5

def main(params)
  has_path = ARGV[0].nil? ? TEMP_FILE : File.absolute_path(ARGV[0])
  if has_path == TEMP_FILE
    File.open(has_path, 'w+') do |tmp_file|
      readlines.each { |line| tmp_file.write line }
    end
  end

  File.open(has_path) do |file|
    file_name = has_path == TEMP_FILE ? '' : has_path.split('/')[-1]
    file_body = file.read
    file_size = file.size
    n_lines = file_body.count("\n")
    n_lines += 1 if /[^\n]\z/.match?(file_body)
    n_words = file_body.scan(/[!-~]+/).size

    if params[:lines]
      printf("%#{WIDTH}d %s\n", n_lines, file_name)
    else
      printf("%#{WIDTH}d %#{WIDTH}d %#{WIDTH}d %s\n", n_lines, n_words, file_size, file_name)
    end
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

main params

exec("ruby #{__dir__}/wc.rb#{' -l' if params[:lines]} #{ARGV.drop(1).join(' ')}") unless ARGV[1].nil?
