#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
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
  params[:long_format] ? long_format(files) : short_format(files, display_width)
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

###### ↓↓↓↓↓-lオプション用のメソッド↓↓↓↓↓ #####
# -lが指定された場合の表示
def long_format(files)
  if !ARGV[0].nil?
    files.map! { |file| { name: file, info: File.lstat(ARGV[0] + file) } }
  else
    files.map! { |file| { name: file, info: File.lstat(file) } }
  end
  widthes = select_widthes(files)
  printf("total\s%d\n", (files.map { |file| file[:info].size }.max / 512.to_f).ceil)
  files.each do |file|
    print_line(file, widthes)
  end
end

def print_type_and_parmit(file_info)
  # ファイルタイプとパーミッションを八進数7桁文字列に変換
  type_and_permisson = format('%#07o', file_info.mode)

  # ファイルタイプの記述
  type = type_and_permisson.slice(1, 2)
  print_type(type)

  # 各対象ごとにパーミッションを記述
  3.times do |time|
    permisson = type_and_permisson[time + 4]
    print_permisson(permisson)
  end
  printf "\s\s"
end

def print_type(type)
  printf 'p' if type == '01'
  printf 'c' if type == '02'
  printf 'd' if type == '04'
  printf 'b' if type == '06'
  printf '-' if type == '10'
  printf 'l' if type == '12'
  printf 's' if type == '14'
end

def print_permisson(permisson)
  permits = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'r-w', 'rwx']
  print permits[permisson.to_i]
end

def select_widthes(files)
  widthes = {}
  widthes[:link_width] = files.map { |file| file[:info].nlink }.max.to_s.length
  widthes[:owner_width] = files.map { |file| Etc.getpwuid(file[:info].uid).name.length }.max
  widthes[:group_width] = files.map { |file| Etc.getgrgid(file[:info].gid).name.length }.max
  widthes[:size_width] = files.map { |file| file[:info].size }.max.to_s.length
  widthes[:time_width] = 2
  widthes
end

def print_line(file, widthes)
  print_type_and_parmit(file[:info])
  printf("%#{widthes[:link_width]}d\s", file[:info].nlink)
  printf("%#{widthes[:owner_width]}s\s\s", Etc.getpwuid(file[:info].uid).name)
  printf("%#{widthes[:group_width]}s\s\s", Etc.getgrgid(file[:info].gid).name)
  printf("%#{widthes[:size_width]}d\s", file[:info].size)
  printf("%#{widthes[:time_width]}d\s%#{widthes[:time_width]}d\s", file[:info].mtime.month, file[:info].mtime.day)
  printf("%#{widthes[:time_width]}d:%#{widthes[:time_width]}d\s", file[:info].mtime.hour, file[:info].mtime.min)
  puts file[:name]
end
###### ↑↑↑↑↑-lオプション用のメソッド↑↑↑↑↑ #####

main
