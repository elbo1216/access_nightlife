class GalleryImages < ActiveRecord::Migration
  def self.up
    sql = "create table gallery_images (
              id                 integer not null auto_increment primary key,
              gallery_id         integer not null references galleries(id),
              image_path         varchar(255) not null,
              image_filename     varchar(255) not null,
              image_comments     varchar(100),
              is_slideshow_image boolean not null default false,
              is_media_image     boolean default false,
              created_at         timestamp default '0000-00-00 00:00:00',
              updated_at         timestamp default now() on update now())
"
    execute sql
  end

  def self.down
    drop_table :gallery_images
  end
end
