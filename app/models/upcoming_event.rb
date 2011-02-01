class UpcomingEvent < ActiveRecord::Base

	belongs_to :event
	
	ASIAN = 'a'
    MIXED = 'm'
	MAX_EVENTS = 3

    def UpcomingEvent.synchronize_upcoming_events
      @upcoming_asian_events = UpcomingEvent.find_by_sql("select * from upcoming_events ue where event_type = 'a' order by event_order") 
      if @upcoming_asian_events.size < UpcomingEvent::MAX_EVENTS
        for i in @upcoming_asian_events.size..UpcomingEvent::MAX_EVENTS-1
          UpcomingEvent.create(:event_order => i+1, :event_type => UpcomingEvent::ASIAN)
        end
      end
      @upcoming_mixed_events = UpcomingEvent.find_by_sql("select * from upcoming_events where event_type = 'm' order by event_order") 
      if @upcoming_mixed_events.size < UpcomingEvent::MAX_EVENTS
        for i in @upcoming_mixed_events.size..UpcomingEvent::MAX_EVENTS-1
          UpcomingEvent.create(:event_order => i+1, :event_type => UpcomingEvent::MIXED)
        end
      end
    end
end
