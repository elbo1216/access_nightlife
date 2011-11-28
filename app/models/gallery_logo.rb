class GalleryLogo < ActiveRecord::Base
  has_many :galleries

  def create_path
    self.logo_path = "/images/gallery_logos/"
    path_check = "#{RAILS_ROOT}/public"
    self.logo_path.split('/').each do |dir|
      path_check += "/#{dir}"
      unless File.directory?(path_check)
        Dir.mkdir(path_check)
      end
    end
  end

  def upload_image(upload)
    if upload.blank?
      return
    end

    create_path if self.logo_path.blank?
    if self.logo_file_name.blank?
      self.logo_file_name = "logo_#{ActiveSupport::SecureRandom.hex(10)}_#{Time.now.strftime("%d_%m_%y")}.jpg" until unique_filename?
    end
    file = File.join(RAILS_ROOT, 'public', self.logo_path, self.logo_file_name)
    File.open(file, "wb") { |f| f.write(upload.read) }
  end

  def unique_filename?
    self.logo_file_name.blank? ? nil : GalleryLogo.find_by_sql("select * from gallery_logos where logo_file_name = '#{self.logo_file_name}'").blank?
  end

end
