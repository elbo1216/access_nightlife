class SocialMediaAccounts < ActiveRecord::Migration
  def self.up
    sql = "create table social_media_accounts (
             id          integer not null auto_increment primary key,
             media_name  varchar(255),
             media_url   varchar(2000),
             created_at timestamp default '0000-00-00 00:00:00',
             updated_at timestamp default now() on update now())"
     execute sql 
  end

  def self.down
    sql = "drop table social_media_accounts;"
    execute sql;
  end
end
