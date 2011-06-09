class Util
  def Util.make_file_path(path)
    path_arr = path.split('/')
    existing_path = ''
    path_arr.each do |dir|
      existing_path = existing_path + '/' + dir
      Dir.mkdir(existing_path) unless Dir.exist?(existing_path)
    end
  end
end
