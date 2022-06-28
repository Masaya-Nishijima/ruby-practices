# frozen_string_literal: true

require 'etc'
class File
  TYPE_HASH = { '01' => 'p', '02' => 'c', '04' => 'd', '06' => 'b', '10' => '-', '12' => 'l', '14' => 's' }.freeze
  PERMITS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'].freeze

  def name
    File.basename(self)
  end

  def type
    TYPE_HASH[mode_octal.slice(1, 2)]
  end

  def mode_rwx_owner
    mode_rwx[0]
  end

  def mode_rwx_group
    mode_rwx[1]
  end

  def mode_rwx_other
    mode_rwx[2]
  end

  def n_link
    lstat.nlink
  end

  def owner
    Etc.getpwuid(lstat.uid).name
  end

  def group
    Etc.getgrgid(lstat.gid).name
  end

  def size
    lstat.size
  end

  def time_for_ls
    "#{time.month.to_s.rjust(2)} #{time.day.to_s.rjust(2)} #{time.hour.to_s.rjust(2, '0')}:#{time.min.to_s.rjust(2, '0')}"
  end

  private

  def mode_octal
    format('%#07o', lstat.mode)
  end

  def mode_rwx
    mode_octal[4..].split('').map { |group| PERMITS[group.to_i] }
  end

  def time
    lstat.mtime
  end
end
