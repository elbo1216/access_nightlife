class CreateUpcomingEvents < ActiveRecord::Migration
  def self.up
	sql = "CREATE TABLE upcoming_events (
			id			integer not null auto_increment primary key,
			event_id	integer references events(id),
			event_type	varchar(1) not null,
			event_order integer,
   created_at 	timestamp default '0000-00-00 00:00:00',
   updated_at 	timestamp default now() on update now()
		  )"
	execute sql
  end

  def self.down
    drop_table :upcoming_events
  end
end
