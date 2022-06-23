#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
WIDTH = 5

def main
  params = read_option
  files = ARGV[0].nil? ? [{ name: '', body: readlines.join }] : ARGV.map { |file| { name: file, body: File.open(file).read } }
  total = files.map { |file| count_and_print_wc_element(params, file) }
  return if files.size < 2

  total.transpose.map(&:sum).each { |value| printf("%#{WIDTH}d ", value) }
  puts('total')
end

def read_option
  params = {}
  opt = OptionParser.new
  opt.on('-l', '--lines') { |v| params[:lines] = v }
  opt.parse!(ARGV)
  params
end

def count_and_print_wc_element(params, file)
  file_size = file[:body].bytesize
  n_lines = file[:body].count("\n")
  n_lines += 1 if /[^\n]\z/.match?(file[:body])
  n_words = file[:body].scan(/[!-~]+/).size
  printf("%#{WIDTH}d ", n_lines)
  printf("%#{WIDTH}d %#{WIDTH}d ", n_words, file_size) unless params[:lines]
  printf("%s\n", file[:name])
  params[:lines] ? [n_lines] : [n_lines, n_words, file_size]
end

main
