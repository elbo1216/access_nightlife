class UpcomingEvent < ActiveRecord::Base

	belongs_to :event
	
	ASIAN = 'a'
    MIXED = 'm'
end
