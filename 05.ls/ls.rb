#!/usr/bin/env ruby
# frozen_string_literal: true

WIDTH = 3

# 入力された一次元配列を、WIDTH幅の二次元配列にする関数
def sort_array(array)
  height = (array.size.to_f / WIDTH).ceil
  answer_array = []

  if array.size < 3 # 要素数が3以下のときの処理(一行で表示が終わる)
    middle_array = Array.new(array.size) { |time| array[time] }
    return answer_array << middle_array
  end

  array = array.each_slice(height).to_a
  height.times do |row|
    answer_array << Array.new(WIDTH) { |column| array[column][row] }
  end
  answer_array
end

# パス内のファイルを取得するメソッド(引数なしのときはカレントディレクトリ)
def list_up_files(directory = Dir.getwd)
  Dir.glob('*', base: directory)
end

files = # カレントディレクトリor指定パスのファイルを取得する
  if ARGV[0].nil?
    list_up_files
  else
    list_up_files(File.absolute_path(ARGV[0]))
  end

display_width = files.map(&:length).max +  7 # 長い名前のファイルがあって、最低でも7マスは空白ができるように設定
if display_width < 24 then display_width = 24 end # デフォルトのファイル名の幅 組み込みlsを参考に設定
files = sort_array(files.sort)
files.size.times do |time|
  WIDTH.times do |column|
    printf('%-*s', display_width, files[time][column])
  end
  puts
end
