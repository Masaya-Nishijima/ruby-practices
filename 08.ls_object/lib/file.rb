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
    self.lstat.nlink
  end

  def owner
    Etc.getpwuid(self.lstat.uid).name
  end

  def group
    Etc.getgrgid(self.lstat.gid).name
  end

  def size
    self.lstat.size
  end

  def time
    self.lstat.mtime
  end

  private
  def mode_octal
    format('%#07o', self.lstat.mode)
  end

  def mode_rwx
    mode_octal[4..-1].split('').map {|group| PERMITS[group.to_i]}
  end
end
