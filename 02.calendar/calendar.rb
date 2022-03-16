params = {}

require 'date'  #現在の日付を取得する。
params[:month] = Date.today.month
params[:year] = Date.today.year

require 'optparse'  #コマンドライン引数から月・年を取る
opt = OptionParser.new
opt.on('-m VAL', '--month')
opt.on('-y VAL', '--year')
opt.parse!(ARGV, into: params)



puts "      #{params[:month]}月 #{params[:year]}" #一行目の表示用
