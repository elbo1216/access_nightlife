class Event < ActiveRecord::Base

	belongs_to :flyer
	has_one :upcoming_event
	has_one :event_request
 has_many :gallery

end
