class Argument
  attr_reader :path
  def initialize
    @params = read_option
    @path = ARGV[0]
  end

  def reverse?
    @params[:reverse]
  end

  def all?
    @params[:all]
  end

  def long?
    @params[:long_format]
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
