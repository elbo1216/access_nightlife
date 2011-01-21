class AccessController < ApplicationController
  layout "base_layout"

  def index
	@upcoming_events = UpcomingEvent.all
	@upcoming_asian_events = @upcoming_events.select { |ue| ue.event_type == 'a' }
	@upcoming_mixed_events = @upcoming_events.select { |ue| ue.event_type == 'm' }
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

end
