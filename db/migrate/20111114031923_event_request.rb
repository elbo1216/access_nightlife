class EventRequest < ActiveRecord::Migration
  def self.up
    sql = "create table event_requests (
            id                       integer not null auto_increment primary key,
            user_id                  integer,
            event_date_requested	    date,
            event_for                varchar(100),
            number_of_ladies         integer,
            number_of_men            integer,
            bottle_service           varchar(100),
            city                     varchar(100),
            neighborhood             varchar(100),
            preferred_venue										varchar(100),
            comments                 text,
            has_contacted	           boolean not null default false,
            contacted_by             varchar(100),
            event_id                 integer,
            created_at timestamp     default '0000-00-00 00:00:00',
            updated_at timestamp     default now() on update now()
          )"
    execute sql
  end

  def self.down
    drop_table :event_requests
  end
end
