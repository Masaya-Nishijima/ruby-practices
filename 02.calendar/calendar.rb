params = {}

require 'optparse'
opt = OptionParser.new
opt.on('-m VAL', '--month') {|v| p month = v}
opt.on('-y VAL', '--year') {|v| p year = v}
opt.parse!(ARGV, into: params)


#puts "      #{params[:month]}月 #{params[:year]}"

