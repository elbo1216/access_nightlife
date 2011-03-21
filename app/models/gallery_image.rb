class GalleryImage < ActiveRecord::Base
  belongs_to :gallery

  def before_create
    self.image_path = "/images/gallery/#{self.gallery_id}/"
    path_check = "#{RAILS_ROOT}/public"
    self.image_path.split('/').each do |dir|
      path_check += "/#{dir}"
      unless File.directory?(path_check)
        Dir.mkdir(path_check)
      end
    end
    self.image_filename = "gi_#{ActiveSupport::SecureRandom.hex(10)}_#{Time.now.strftime("%d_%m_%y")}.jpg" until unique_filename?
  end

  def before_destroy
    file = "#{RAILS_ROOT}/public/#{self.image_path}/#{self.image_filename}"
    File.delete(file)
  end

  def upload_image(upload)
    if upload.blank? || self.gallery_id.blank?
      return
    end
    if self.image_filename.blank?
      self.image_filename = "gi_#{ActiveSupport::SecureRandom.hex(10)}_#{Time.now.strftime("%d_%m_%y")}.jpg" until unique_filename?
    end
    file = File.join(RAILS_ROOT, 'public', self.image_path, self.image_filename)
    File.open(file, "wb") { |f| f.write(upload.read) }
  end

  def unique_filename?
    self.image_filename.blank? ? nil : GalleryImage.find_by_sql("select * from gallery_images where image_filename = '#{self.image_filename}'").blank?
  end

end
