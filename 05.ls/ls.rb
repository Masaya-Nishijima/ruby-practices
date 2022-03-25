#!/usr/bin/env ruby
# frozen_string_literal: true
WIDTH = 3

def sort_array(array) # 入力された一次元配列を、WIDTH幅の二次元配列にする関数
  height = (array.size.to_f / WIDTH).ceil
  answer_array = []

  if array.size < 3 # 要素数が3以下のときの処理(一行で表示が終わる)
    middle_array = []
    array.size.times do |time|
      middle_array << array[time]
    end
    return answer_array << middle_array
  end

  array = array.each_slice(height).to_a
  height.times do |row|
    middle_array = []
    WIDTH.times do |column|
      middle_array << (array[column][row])
    end
    answer_array << middle_array
  end
  answer_array
end

def catch_file(directory = Dir.getwd) # パス内のファイルを取得するメソッド(引数なしのときはカレントディレクトリ)
  items = []
  Dir.foreach(directory) do |item|
    next if /^\..*/.match?(item)

    items << item
  end
  items
end

files = # カレントディレクトリor指定パスのファイルを取得する
  if ARGV[0].nil?
    catch_file
  else
    catch_file(File.absolute_path(ARGV[0]))
  end

files = sort_array(files.sort)
files.size.times do |time|
  WIDTH.times do |column|
    printf('%-24s', files[time][column])
  end
  puts
end
