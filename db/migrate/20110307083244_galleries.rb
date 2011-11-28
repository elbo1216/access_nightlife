class Galleries < ActiveRecord::Migration
  def self.up
    sql = "create table galleries (
              id                   integer not null auto_increment primary key,
              name																	varchar(255),
              description_short    varchar(255),
              description_long     varchar(1024),
              event_id				         integer,
              gallery_path         varchar(255),
              gallery_logo_id      integer,
              is_current_slideshow boolean not null default false,
              is_feature_gallery   boolean not null default false,
              is_live              boolean not null default false,
              created_at           timestamp default '0000-00-00 00:00:00',
              updated_at           timestamp default now() on update now())
"
    execute sql
  end

  def self.down
    drop_table :galleries
  end
end
