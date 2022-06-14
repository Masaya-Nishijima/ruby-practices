#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  params = read_option

  has_path = ARGV[0].nil? ? nil : File.absolute_path(ARGV[0])
  p file_name = has_path.split('/')[-1]
  file = File.open(has_path)
  file_body = file.read
  file_size = file.size
  file.close

  n_lines = file_body.count("\n")
  n_lines += 1 if /[^\n]\z/ =~ file_body

  n_words = file_body.scan(/[!-~]+/).size
  if params[:lines]
    printf("%8d %s\n", n_lines, file_name)
  else
    printf("%5d %5d %5d %s\n", n_lines, n_words, file_size, file_name)
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
