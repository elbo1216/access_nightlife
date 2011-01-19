class CreateUsers < ActiveRecord::Migration
  def self.up
    sql = "create table users (
             id         integer not null auto_increment primary key,
             firstname  varchar(50),
             lastname  varchar(50),
             email     varchar(50),
             phone     varchar(10),
			 birthday  varchar(8),
             is_admin_user boolean,
             created_at timestamp default '0000-00-00 00:00:00',
             updated_at timestamp default now() on update now())"
    execute sql
  end

  def self.down
  end
end
