class GalleryImages < ActiveRecord::Migration
  def self.up
    sql = "create table gallery_images (
              id                 integer not null auto_increment primary key,
              gallery_id         integer not null references galleries(id),
              image_path         varchar(50) not null,
              image_filename     varchar(50) not null,
              image_comments     varchar(100),
              is_slideshow_image boolean not null default false,
              created_at         timestamp default '0000-00-00 00:00:00',
              updated_at         timestamp default now() on update now())
"
    execute sql
  end

  def self.down
  end
end
