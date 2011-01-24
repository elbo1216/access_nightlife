class Flyer < ActiveRecord::Base

  has_one :event

  def upload_flyer(upload)
    self.file_path = "#{RAILS_ROOT}/public/images/flyers/"
    self.filename = "#{ActiveSupport::SecureRandom.hex(10)}_#{Time.now.strftime("%d_%m_%y")}.jpg" until unique_filename?
    file = File.join(self.file_path, self.filename)
    File.open(file, "wb") { |f| f.write(upload['datafile'].read) }
  end

  def unique_filename?
    self.filename.blank? ? nil : Flyer.find_by_sql("select * from flyers where filename = '#{self.filename}'").blank?
  end
end
