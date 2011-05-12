class MusicFile < ActiveRecord::Base

  def upload_music_file(upload, fname)
    if upload.blank?
      return
    end
    self.file_path = "/music/"
    self.filename = "#{Time.now.strftime("%Y%d%m%H%M")}_#{fname}"
    path = File.join(RAILS_ROOT, '/public', self.file_path)
    Util.make_file_path(path)
    file = File.join(path, self.filename)
    File.open(file, "wb") { |f| f.write(upload['file'].read) }
  end

  def delete_file
    File.delete(File.join(RAILS_ROOT, '/public', self.file_path, self.filename))
    self.destroy
  end

  def set_music_file_active!
    mf = MusicFile.find(:first, :conditions => ['is_active = 1'])
    if mf
      mf.is_active = 0
      mf.save!
    end
    self.is_active = 1
    save!
  end
end
