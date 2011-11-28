class AccessController < ApplicationController
  layout "base_layout"

  def index
	   @events = UpcomingEvent.all
	   @featured_event = @events.select { |ue| ue.event_type == 'f' }
	   @upcoming_events = @events.select { |ue| ue.event_type == 'u' }
    @image_arr = []
    GalleryImage.find(:all, :conditions => 'is_slideshow_image = 1').each do |ss|
      @image_arr << "['#{ss.image_path}/#{ss.image_filename}','','','#{ss.image_comments}']" 
    end
  end

  def add_request
   if request.post?
	    if params[:email_address]
       user = User.find_by_sql("select * from users where email = '#{params[:email_address]}'")
       if user.blank?
  	     user = User.new
       end
       user.firstname = params[:first_name]
       user.lastname = params[:last_name]
       user.email = params[:email_address]
       user.phone = params[:phone_number]
       user.birthday = "#{params[:birthday_yr]}-#{params[:birthday_mon]}-#{params[:birthday_dy]}"
       user.save!
       if params[:request_type] == 'event'  
         req = EventRequest.new
         req.user_id = user.id
         req.save!
       elsif params[:request_type] == 'newsletter'
         req = NewsletterRequest.new
         req.user_id = user.id
         req.save!
       else
       end
     end

	    render :nothing => true
   end
  end

  def contact
    if request.post?
      email_address = params[:email_address]
      return if email_address.blank?
      user = User.find_by_sql("select * from users where email = '#{params[:email_address]}'").first
      if user.blank?
        user = User.new
        user.firstname = params[:first_name]
        user.lastname = params[:last_name]
        user.email = params[:email_address]
        user.phone = params[:phone]
        user.save!
      end
      cr = ContactRequest.new
      cr.user_id = user.id
      cr.comments = params[:comments]
      cr.save!
      render 'access/request_confirm.html.erb'
    end
  end

  def plan_event
    if request.post?
      email_address = params[:email_address]
      return if email_address.blank?
      user = User.find_by_sql("select * from users where email = '#{params[:email_address]}'").first
      er = EventRequest.new
      if user.blank?
        user = User.new
        user.firstname = params[:first_name]
        user.lastname = params[:last_name]
        user.email = params[:email_address]
        user.phone = params[:phone]
        user.save!
      end
      er.user_id = user.id
      er.event_date_requested = params[:date_of_event]
      er.number_of_ladies = params[:num_of_ladies]
      er.number_of_men = params[:num_of_men]
      er.bottle_service = params[:bottle_service]
      er.city = params[:city]
      er.neighborhood = params[:neighborhood]
      er.preferred_venue = params[:preferred_venue]
      er.comments = params[:comments]
      er.save!
      render 'access/request_confirm.html.erb'
    end
  end

  def about
  end

  def media
    @galleries = Gallery.find_by_sql("select * from galleries where is_feature_gallery is false order by id desc limit 4 ")
    @feature_gallery = Gallery.find_by_sql("select * from galleries where is_feature_gallery is true").first
    render 'access/media_main.html.erb'
  end
end
