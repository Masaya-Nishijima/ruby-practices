#!/usr/bin/env ruby

score = ARGV[0]
scores =score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

if frames[10] != nil #11フレーム目以降がある(10フレーム目にスペアかストライクがある。)
  if frames[11] != nil #12フレーム目がある(10フレーム目が"ストライク-ストライク-3投目"である。)
    3.times do |x|  #ストライクの[10, 0]の0を消す。
      if frames[9+x][1] == 0
        frames[9+x].pop
      end
    end
    frames[9].push(frames[10][0])
    frames[9].push(frames[11][0])
    frames.pop(2)
  elsif frames[9] ==[10, 0] #10フレームでストライク("ストライク-ストライク-3投目"を除く)
    frames[9].pop
    frames[9].push(frames[10][0])
    frames[9].push(frames[10][1])
    frames.pop
  else  #10フレームでスペア
    frames[9].push(frames[10][0])
    frames.pop
  end
end
p frames ##デバッグ用


=begin
point = 0
frames.each_with_index do |frame, frame_index|
  if frame_index == 10
    point += frame.sum
  else
    point += frame.sum
    if frame[0] == 10 # strike
      point += frames[frame_index + 1][0]
    elsif frame.sum == 10 # spare
      point += frames[frame_index + 1][0]
      p frames[frame_index + 1]
    end
  end
end
puts point
=end
