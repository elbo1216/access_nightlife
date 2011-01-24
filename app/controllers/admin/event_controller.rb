module Admin
  class EventController < AdminController
	layout "admin_layout"

	def index
      @events = Event.find_by_sql("select * from events e join upcoming_events ue on ue.event_id = e.id order by e.id desc limit 20")
	end

    def create
	  @method = 'Create'
      if request.post?
        flyer = Flyer.new
        flyer.upload_flyer(params['flyer'])
        flyer.save

        event = Event.new
        event.event_name = params['event_name']
        event.event_address = params['event_address']
        event.venue = params['venue']
        event.flyer_id = flyer.id
        event.event_start_time = params['event_start_time']
        event.event_notes1_label = params['event_notes1_label']
        event.event_notes1 = params['event_notes1']
        event.event_notes1_label = params['event_notes2_label']
        event.event_notes1 = params['event_notes2']
        event.event_notes1_label = params['event_notes3_label']
        event.event_notes1 = params['event_notes3']
        event.save!

        flash[:notice] = "Event Saved"
        redirect_to :action => 'index'
      end

    end

    def update
	  @method = 'Update'
      @event = Event.find_by_sql("select * from events e left join upcoming_events ue on ue.event_id = e.id where e.id = #{params['id']}").first
      if request.post?
        if params['flyer'].blank?
          flyer = Flyer.new
          flyer.upload_flyer(params['flyer'])
          flyer.save
         end

        event = Event.new
        event.event_name = params['event_name']
        event.event_address = params['event_address']
        event.venue = params['venue']
        event.flyer_id = flyer.id
        event.event_start_time = params['event_start_time']
        event.event_notes1_label = params['event_notes1_label']
        event.event_notes1 = params['event_notes1']
        event.event_notes1_label = params['event_notes2_label']
        event.event_notes1 = params['event_notes2']
        event.event_notes1_label = params['event_notes3_label']
        event.event_notes1 = params['event_notes3']
        event.save!
        
        flash[:notice] = "Event Updated"
      end

      render :create
    end  
  end
end
