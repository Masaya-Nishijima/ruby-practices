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

files = # カレントディレクトリor指定パスのファイルを取得する
  if ARGV[0].nil?
    Dir.glob('*', base: Dir.getwd)
  else
    Dir.glob('*', base: File.absolute_path(ARGV[0]))
  end

display_width = [files.map(&:length).max + 7, 24].max # 最低でも7マスは空白ができるように設定 デフォルトのファイル名の幅として24を指定している。 組み込みlsを参考に設定
files = sort_array(files.sort)
files.size.times do |time|
  WIDTH.times do |column|
    printf('%-*s', display_width, files[time][column])
  end
  puts
end
