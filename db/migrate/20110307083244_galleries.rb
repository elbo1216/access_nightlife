class Galleries < ActiveRecord::Migration
  def self.up
    sql = "create table galleries (
              id                   integer not null auto_increment primary key,
              name																	varchar(255),
              event_id				         integer,
              gallery_path         varchar(50),
              is_current_slideshow boolean default false,
              created_at           timestamp default '0000-00-00 00:00:00',
              updated_at           timestamp default now() on update now())
"
    execute sql
  end

  def self.down
  end
end
