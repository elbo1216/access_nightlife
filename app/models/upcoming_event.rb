class UpcomingEvent < ActiveRecord::Base

	 belongs_to :event
	
  FEATURED = 'f'
  UPCOMING = 'u'
	 MAX_EVENTS = 3

  def UpcomingEvent.synchronize_upcoming_events
      featured_event = UpcomingEvent.find_by_sql("select * from upcoming_events ue where event_type = 'f' order by event_order") 
      if featured_event.blank?
        UpcomingEvent.create(:event_order => 1, :event_type => UpcomingEvent::FEATURED)
      end
      upcoming = UpcomingEvent.find_by_sql("select * from upcoming_events where event_type = 'u' order by event_order") 
      if upcoming.size < UpcomingEvent::MAX_EVENTS
        for i in upcoming.size..UpcomingEvent::MAX_EVENTS-1
          UpcomingEvent.create(:event_order => i+1, :event_type => UpcomingEvent::UPCOMING)
        end
      end
    end

end
