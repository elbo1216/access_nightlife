module Admin
  class EventController < AdminController
	layout "admin_layout"

	def index
      @upcoming_asian_events = UpcomingEvent.find_by_sql("select * from upcoming_events ue where event_type = 'a' order by event_order") 
      @upcoming_mixed_events = UpcomingEvent.find_by_sql("select * from upcoming_events where event_type = 'm' order by event_order") 
      if @upcoming_asian_events.size < UpcomingEvent::MAX_EVENTS || @upcoming_mixed_events.size < UpcomingEvent::MAX_EVENTS
        UpcomingEvent.synchronize_upcoming_events
      end
      @events = Event.find_by_sql("select * from events e order by e.id desc limit 20")
	end

    def create
	  @method = 'Create'
      @event = Event.new
      @flyer = Flyer.new
      if request.post?
        if params['flyer']
          @flyer.upload_flyer(params['flyer'])
          @flyer.save!
        end

        @event.event_name = params['event_name']
        @event.event_address = params['event_address']
        @event.venue = params['venue']
        @event.flyer_id = @flyer.id if params['flyer']
        @event.event_start_date = params['event_start_date']
        @event.event_start_time = params['event_start_time']
        @event.event_notes1_label = params['event_notes1_label']
        @event.event_notes1 = params['event_notes1']
        @event.event_notes2_label = params['event_notes2_label']
        @event.event_notes2 = params['event_notes2']
        @event.event_notes3_label = params['event_notes3_label']
        @event.event_notes3 = params['event_notes3']
        @event.save!

        flash[:notice] = "Event Saved"
        redirect_to :action => 'index'
      end

    end

    def update
	     @method = 'Update'
      @event = Event.find_by_sql("select * from events e where e.id = #{params['id']}").first
      @flyer = @event.flyer || Flyer.new
      if request.post?
        if @event.flyer.blank?
          @flyer.upload_flyer(params['flyer'])
          @flyer.save
         end

        @event.event_name = params['event_name']
        @event.event_address = params['event_address']
        @event.venue = params['venue']
        @event.flyer_id = @flyer.id if @event.flyer.blank?
        @event.event_start_date = params['event_start_date']
        @event.event_start_time = params['event_start_time']
        @event.event_notes1_label = params['event_notes1_label']
        @event.event_notes1 = params['event_notes1']
        @event.event_notes2_label = params['event_notes2_label']
        @event.event_notes2 = params['event_notes2']
        @event.event_notes3_label = params['event_notes3_label']
        @event.event_notes3 = params['event_notes3']
        @event.save!
        
        flash[:notice] = "Event Updated"
        redirect_to :action => 'index'
        return
      end

      render :create
    end  

    def delete
      @event = Event.find(params[:id])
      @event.destroy
      flash[:notice] = "Event deleted"
      render :index
    end

    def change_upcoming_event
      @upcoming_event = UpcomingEvent.find_by_sql("select * from upcoming_events where id = #{params['id']}").first
      @upcoming_event.event_id = params['event_id']
      @upcoming_event.save!
      @upcoming_event.reload
      render :text => @upcoming_event.event.event_name
    end

    def remove_upcoming_event
      @upcoming_event = UpcomingEvent.find_by_sql("select * from upcoming_events where id = #{params['id']}").first
      @upcoming_event.event_id = nil
      @upcoming_event.save!
      render :nothing => true
    end
  end
end
