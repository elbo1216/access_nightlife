class Affiliate < ActiveRecord::Base
  def upload_affiliate_image(upload, fname)
    if upload.blank?
      return
    end
    self.img_file_path = "/images/affiliate"
    self.img_filename = "#{Time.now.strftime("%Y%d%m%H%M")}_#{fname}"
    path = File.join(RAILS_ROOT, '/public', self.img_file_path)
    Util.make_file_path(path)
    file = File.join(path, self.img_filename)
    File.open(file, "wb") { |f| f.write(upload['image'].read) }
  end

  def delete_file
    File.delete(File.join(RAILS_ROOT, '/public', self.img_file_path, self.img_filename))
    self.destroy
  end

  def set_active!
    self.is_active = 1
    self.save!
  end

  def set_inactive!
    self.is_active = 0
    self.save!
  end
end
