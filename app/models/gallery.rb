class Gallery < ActiveRecord::Base
  belongs_to :event
  belongs_to :gallery_logo
  has_many :gallery_images

  def get_media_image
    gallery_images.select {|gi| gi.is_media_image }.first
  end

  def add_to_slideshow
    self.is_current_slideshow = true
    self.save!
  end
 
  def remove_from_slideshow
    self.is_current_slideshow = false
    self.save!
  end

  def make_live
    self.is_live = true
    self.save!
  end

  def remove_live
    self.is_live = false
    self.save!
  end

  def make_feature
    self.is_feature_gallery = true
    self.save!
  end

  def remove_feature
    self.is_feature_gallery = false
    self.save!
  end


  def edit_comment(comment)
    self.image_comments = comment
    self.save!
  end
end
