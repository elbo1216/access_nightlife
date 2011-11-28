module Admin
  class EventController < AdminController
	   layout "admin_layout"
    before_filter :authorize_promoter

	     def index
           @featured_event = UpcomingEvent.find_by_sql("select * from upcoming_events ue where event_type = 'f' order by event_order").first
           @upcoming_events = UpcomingEvent.find_by_sql("select * from upcoming_events where event_type = 'u' order by event_order") 
           if @upcoming_events.size < UpcomingEvent::MAX_EVENTS
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
          @event = Event.new(params['event'])
          @event.flyer_id = @flyer.id
          @event.event_notes1_styles = params['event_styles1'].join(',') unless params['event_styles1'].blank?
          @event.event_notes2_styles = params['event_styles2'].join(',') unless params['event_styles2'].blank?
          @event.event_notes3_styles = params['event_styles3'].join(',') unless params['event_styles3'].blank?
          @event.event_name_styles = params['event_styles_name'].join(',') unless params['event_styles_name'].blank?
          @event.event_venue_styles = params['event_styles_venue'].join(',') unless params['event_styles_venue'].blank?
          @event.event_address_styles = params['event_styles_address'].join(',') unless params['event_styles_address'].blank?
          @event.event_start_date_styles = params['event_styles_date'].join(',') unless params['event_styles_date'].blank?
          @event.event_start_time_styles = params['event_styles_time'].join(',') unless params['event_styles_time'].blank?
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

        @event.update_attributes(params['event'])
        @event.flyer_id = @flyer.id
          @event.event_notes1_styles = params['event_styles1'].join(',') unless params['event_styles1'].blank?
          @event.event_notes2_styles = params['event_styles2'].join(',') unless params['event_styles2'].blank?
          @event.event_notes3_styles = params['event_styles3'].join(',') unless params['event_styles3'].blank?
          @event.event_name_styles = params['event_styles_name'].join(',') unless params['event_styles_name'].blank?
          @event.event_venue_styles = params['event_styles_venue'].join(',') unless params['event_styles_venue'].blank?
          @event.event_address_styles = params['event_styles_address'].join(',') unless params['event_styles_address'].blank?
          @event.event_start_date_styles = params['event_styles_date'].join(',') unless params['event_styles_date'].blank?
          @event.event_start_time_styles = params['event_styles_time'].join(',') unless params['event_styles_time'].blank?
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
      redirect_to :action => 'index'
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
