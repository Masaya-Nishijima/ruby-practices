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

if frames[10] != nil #11フレーム以降がある(10フレームにスペアかストライクがある。)
  if frames[11] != nil #12フレームがある(10フレームが"ストライク-ストライク-3投目"である。)
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


point = 0
frames.each_with_index do |frame, frame_index|
  if frame_index == 9                               #10フレーム処理
    point += frame.sum
  else                                              #↓↓↓↓↓9フレームまでの処理↓↓↓↓↓
    point += frame.sum                              #通常の加点
    if frame[0] == 10                                 # 1.ストライクの加点
      point += frames[frame_index + 1][0]
      if frames[frame_index + 1][0] == 10               # 1.1.ストライクが連続する場合
        if frame_index == 8                               #1.1.1.次が10フレームの場合
          point += frames[frame_index + 1][1]
        else
          point += frames[frame_index + 2][0]             #1.1.2.次が10フレームでないなら2フレーム先の1投を参照
        end
      else
        point += frames[frame_index + 1][1]             #1.2連続ストライクでない場合
      end
    elsif frame.sum == 10                             # 2.スペアの加点
      point += frames[frame_index + 1][0]
    end
  end                                               #↑↑↑↑↑9フレームまでの処理↑↑↑↑↑
end
puts point
