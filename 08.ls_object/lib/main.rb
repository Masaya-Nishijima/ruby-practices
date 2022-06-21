require 'optparse'
require 'files'

class Main
  attr_reader :params

  def initialize
    @params = read_option
    @files = Files.new(ARGV[0], @params[:all])
  end

  def read_option
    params = {}
    opt = OptionParser.new
    opt.on('-a', '--all') { |v| params[:all] = v }
    opt.on('-r', '--reverse') { |v| params[:reverse] = v }
    opt.on('-l') { |v| params[:long_format] = v }
    opt.parse!(ARGV)
    params
  end

  def print
    @files.print_short_format
  end
end
