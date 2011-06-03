class CreateEventRequests < ActiveRecord::Migration
  def self.up
	sql = "create table event_requests(
             id         	integer not null auto_increment primary key,
			 user_id		integer references users(id),
			 has_contacted  boolean default false,
			 event_id		integer references events(id),
             created_at 	timestamp default '0000-00-00 00:00:00',
             updated_at 	timestamp default now() on update now())"
    execute sql
  end

  def self.down
    drop_table :event_requests
  end
end
