require 'etc'

class Files
  WIDTH = 3
  TYPE_HASH = { '01' => 'p', '02' => 'c', '04' => 'd', '06' => 'b', '10' => '-', '12' => 'l', '14' => 's' }.freeze
  PERMITS = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'r-w', 'rwx'].freeze

  def initialize(path = nil, all = nil)
    has_all = all.nil? ? 0 : File::FNM_DOTMATCH
    @has_path = path.nil? ? Dir.getwd : File.absolute_path(path)
    @files_names = Dir.glob('*', has_all, base: @has_path).sort
    if @files_names == []
      @files_names[0] = path
      has_path.sub!(/[.a-zA-Z0-9]+$/, '')
    end
    @display_width = [@files_names.map(&:length).max + 7, 24].max
  end

  def print_short_format
    files = sort_array(@files_names)
    files.size.times do |time|
      files[time].size.times do |column|
        printf('%-*s', @display_width, files[time][column])
      end
      puts
    end
  end

  def print_long_format()
    files = @files_names.map { |file| { name: file, info: File.lstat("#{@has_path}/#{file}") } }
    files.map! do |file|
      {
        mode: file[:info].mode,
        link: file[:info].nlink,
        owner: Etc.getpwuid(file[:info].uid).name,
        group: Etc.getgrgid(file[:info].gid).name,
        size: file[:info].size,
        time: file[:info].mtime,
        name: file[:name]
      }
    end
    widthes = select_widthes(files)
    printf("total\s%d\n", (files.map { |file| file[:size] }.max / 512.to_f).ceil)
    files.each do |file|
      print_line(file, widthes)
    end
  end

  def reverse!
    @files_names.reverse!
  end

  private

  def sort_array(array)
    height = (array.size.to_f / WIDTH).ceil
    answer_array = []

    if array.size <= WIDTH
      answer_array[0] = array
      return answer_array
    end

    array = array.each_slice(height).to_a
    array.size.times do |row|
      (array[0].size - array[row].size).times { array[row] << nil }
    end
    array.transpose
  end

  def select_widthes(files)
    widthes = {}
    widthes[:link_width] = files.map { |file| file[:link] }.max.to_s.length
    widthes[:owner_width] = files.map { |file| file[:owner].length }.max
    widthes[:group_width] = files.map { |file| file[:group].length }.max
    widthes[:size_width] = files.map { |file| file[:size] }.max.to_s.length
    widthes[:time_width] = 2
    widthes
  end

  def print_line(file, widthes)
    print_type_and_parmit(file[:mode])
    printf("%#{widthes[:link_width]}d\s", file[:link])
    printf("%#{widthes[:owner_width]}s\s\s", file[:owner])
    printf("%#{widthes[:group_width]}s\s\s", file[:group])
    printf("%#{widthes[:size_width]}d\s", file[:size])
    printf("%#{widthes[:time_width]}d\s%#{widthes[:time_width]}d\s", file[:time].month, file[:time].day)
    printf("%#{widthes[:time_width]}d:%#{widthes[:time_width]}d\s", file[:time].hour, file[:time].min)
    puts file[:name]
  end

  def print_type_and_parmit(file_mode)
    # ファイルタイプとパーミッションを八進数7桁文字列に変換
    type_and_permisson = format('%#07o', file_mode)

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
    print TYPE_HASH[type]
  end

  def print_permisson(permisson)
    print PERMITS[permisson.to_i]
  end
end
