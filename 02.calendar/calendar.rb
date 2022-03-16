params = {}

require 'date'  #現在の日付を取得する。
params[:month] = Date.today.month
params[:year] = Date.today.year

require 'optparse'  #コマンドライン引数から月・年を取る
opt = OptionParser.new
opt.on('-m VAL', '--month')
opt.on('-y VAL', '--year')
opt.parse!(ARGV, into: params)

def print_space(x)  #指定数(x)個の空白をprintする関数(表示の整形用)
  x.times do
    print "\s"
  end
end

print_spece(6)
puts "#{params[:month]}月 #{params[:year]}" #一行目の表示用
