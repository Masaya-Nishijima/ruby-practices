#!/usr/bin/env ruby

require 'date'
require 'optparse'


params = {}

params[:month] = Date.today.month  #現在の日付を取得する。
params[:year] = Date.today.year

opt = OptionParser.new  #コマンドライン引数から月・年を取る
opt.on('-m VAL', '--month')
opt.on('-y VAL', '--year')
opt.parse!(ARGV, into: params)
params[:month] = params[:month].to_i
params[:year] = params[:year].to_i

print_cal_point = Date.new(params[:year], params[:month], 1) #表示するカレンダーの位置指定 月の始まりの曜日を参照するため一日を設定

day_of_week = {"Sun" =>  0, "Mon" => 1, "Tue" => 2, "Wed" => 3, "Thu" => 4, "Fri" => 5, "Sat" => 6} #曜日を数字と対応させる。
month_first_day = day_of_week[print_cal_point.strftime('%a')] #月の始まりの曜日を取得する。

def print_space(x)  #指定数(x)個の空白をprintする関数(表示の整形用)
  x.times { print "\s" }
end

print_space(6)
puts "#{params[:month]}月 #{params[:year]}" #一行目の表示用
puts "日 月 火 水 木 金 土" #二行目の表示用

print_space(month_first_day * 3) #月の始まりの曜日まで、記述位置を移動

while true
  if print_cal_point == Date.today    #記述する日付がDate.todayなら色反転を行う。
    print "\e[30m\e[47m"
  end
  printf("%2d", print_cal_point.day)  #日付を記述
  if print_cal_point == Date.today    #色反転の解除処理
    print "\e[0m"
  end

  if (print_cal_point.strftime('%a') == "Sat")  #土曜日なら改行、それ以外なら一つ空白を入れる。
    puts
  else
    print_space 1
  end

  print_cal_point += 1                #日付を一日増やす。
  
  if print_cal_point.day == 1         #日付が1(=一月文の記述終了)ならループを終了する。
    break
  end
end

print "\n\n"                          #表示位置調整
