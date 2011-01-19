class User < ActiveRecord::Base
	has_many :event_requests

end
