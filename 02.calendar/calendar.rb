params = {}

require 'optparse'
opt = OptionParser.new
opt.on('-m VAL', '--month')
opt.on('-y VAL', '--year')
opt.parse!(ARGV, into: params)


puts "      #{params[:month]}月 #{params[:year]}"
