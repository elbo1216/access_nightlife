class CreateEvents < ActiveRecord::Migration
  def self.up
    sql = "create table events(
           id        			            integer not null auto_increment primary key,
		         flyer_id				             integer,
           event_venue              varchar(50),
           event_venue_styles       varchar(50),
           event_name         	     varchar(100),
           event_name_styles        varchar(50),
           event_start_time   	     time,
           event_start_time_styles  varchar(50),
           event_start_date   	     date,
           event_start_date_styles  varchar(50),
           event_address 		         varchar(50),
           event_address_styles     varchar(50),
		         event_notes1_label	      varchar(50),
           event_notes1 		          varchar(50),
           event_notes1_styles      varchar(50),
		         event_notes2_label	      varchar(50),
           event_notes2 		          varchar(50),
           event_notes2_styles      varchar(50),
		         event_notes3_label	      varchar(50),
           event_notes3 		          varchar(50),
           event_notes3_styles      varchar(50),
           created_at timestamp     default '0000-00-00 00:00:00',
           updated_at timestamp     default now() on update now())"
          
    execute sql
  end

  def self.down
    drop_table :events
  end
end
