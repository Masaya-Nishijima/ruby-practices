#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
TEMP_FILE = '.tmp_wc'

def main
  params = read_option

  has_path = ARGV[0].nil? ? TEMP_FILE : File.absolute_path(ARGV[0])
  if has_path == TEMP_FILE
    File.open(has_path, 'w+') do |tmp_file|
      readlines.each do |line|
        tmp_file.write line
      end
    end
  end

  File.open(has_path) do |file|
    file_name = has_path == TEMP_FILE ? '' : has_path.split('/')[-1]
    file_body = file.read
    file_size = file.size
    n_lines = file_body.count("\n")
    n_lines += 1 if /[^\n]\z/ =~ file_body

    n_words = file_body.scan(/[!-~]+/).size
    if params[:lines]
      printf("%8d %s\n", n_lines, file_name)
    else
      printf("%5d %5d %5d %s\n", n_lines, n_words, file_size, file_name)
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

main

unless ARGV[1].nil?
  exec("ruby #{__dir__}/wc.rb #{ARGV.drop(1).join(' ')}")
end
