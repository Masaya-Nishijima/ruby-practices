#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
WIDTH = 3

def main
  params = read_option

  has_all = params[:all].nil? ? 0 : File::FNM_DOTMATCH
  has_path = ARGV[0].nil? ? Dir.getwd : File.absolute_path(ARGV[0])

  files = Dir.glob('*', has_all, base: has_path)
  exit if files == [] # 該当するファイルが内場合プログラム終了
  display_width = [files.map(&:length).max + 7, 24].max # 最低でも7マスは空白ができるように設定 デフォルトのファイル名の幅として24を指定している。 組み込みlsを参考に設定
  files.sort!
  files.reverse! if params[:reverse]
  params[:long_format] ? 0 : short_format(files, display_width)
end

# コマンドの引数を取得
def read_option
  params = {}
  opt = OptionParser.new
  opt.on('-a', '--all') { |v| params[:all] = v }
  opt.on('-r', '--reverse') { |v| params[:reverse] = v }
  opt.on('-l') { |v| params[:long_format] = v }
  opt.parse!(ARGV)
  params
end

# 入力された一次元配列を、WIDTH幅の二次元配列にする関数
def sort_array(array)
  height = (array.size.to_f / WIDTH).ceil
  answer_array = []

  if array.size <= WIDTH # 要素数が3以下のときの処理(一行で表示が終わる)
    answer_array[0] = array
    return answer_array
  end

  array = array.each_slice(height).to_a
  array.size.times do |row| # .transposeで行列の転置をするために、要素数を揃える。
    (array[0].size - array[row].size).times { array[row] << nil }
  end
  array.transpose
end

# -lが指定されていない場合の表示
def short_format(files, display_width)
  files = sort_array(files)
  files.size.times do |time|
    files[time].size.times do |column|
      printf('%-*s', display_width, files[time][column])
    end
    puts
  end
end

main
