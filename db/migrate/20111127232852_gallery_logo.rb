class GalleryLogo < ActiveRecord::Migration
  def self.up
    sql = "create table gallery_logos (
              id                   integer not null auto_increment primary key,
              logo_path            varchar(255),
              logo_file_name       varchar(255),
              created_at           timestamp default '0000-00-00 00:00:00',
              updated_at           timestamp default now() on update now()
          )"
    execute sql
  end

  def self.down
    drop_table :gallery_logos
  end
end
