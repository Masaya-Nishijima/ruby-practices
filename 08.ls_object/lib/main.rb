require 'optparse'

class Main
  attr_reader :params
  def initialize
    @params = read_option
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

end
