# frozen_string_literal: true

require 'optparse'
require './lib/files'

class Main
  # attr_reader :params # 引数処理のスペックを実行する場合はコメントを外す。

  def initialize
    @params = read_option
    @files = Files.new(ARGV[0], @params[:all])
    @files.reverse! if @params[:reverse]
  end

  def print
    @params[:long_format] ? @files.print_long_format : @files.print_short_format
  end

  private

  def read_option
    params = {}
    opt = OptionParser.new
    opt.on('-a', '--all') { |v| params[:all] = v }
    opt.on('-r', '--reverse') { |v| params[:reverse] = v }
    opt.on('-l') { |v| params[:long_format] = v }
    opt.parse!(ARGV)
    params
  end
end
