class Flyer < ActiveRecord::Base

  has_one :event

  validates_presence_of :filename
  validates_presence_of :file_path

  def upload_flyer(upload)
    if upload.blank?
      return
    end
    self.file_path = "/images/flyers/"
    self.filename = "#{ActiveSupport::SecureRandom.hex(10)}_#{Time.now.strftime("%d_%m_%y")}.jpg" until unique_filename?
    file = File.join(RAILS_ROOT, '/public', self.file_path, self.filename)
    File.open(file, "wb") { |f| f.write(upload['datafile'].read) }
  end

  def unique_filename?
    self.filename.blank? ? nil : Flyer.find_by_sql("select * from flyers where filename = '#{self.filename}'").blank?
  end

  def validate
  end

end
