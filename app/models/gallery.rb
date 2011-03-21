class Gallery < ActiveRecord::Base
  belongs_to :event
  has_many :gallery_image

  def add_to_slideshow
    self.is_current_slideshow = true
    self.save!
  end
 
  def remove_from_slideshow
    self.is_current_slideshow = false
    self.save!
  end
end
