class CreateUsers < ActiveRecord::Migration
  def self.up
    sql = "create table users (
             id         integer not null auto_increment primary key,
             firstname  varchar(255),
             lastname  varchar(255),
             email     varchar(255),
             phone     varchar(10),
			          birthday  varchar(8),
             is_admin_user boolean,
             crypted_password varchar(255),
             password_salt varchar(255),
             persistence_token varchar(255),
             login_count integer,
             failed_login_count integer,
             current_login_at datetime,
             last_login_at datetime,
             current_login_ip varchar(100),
             last_login_ip varchar(100),
             created_at timestamp default '0000-00-00 00:00:00',
             updated_at timestamp default now() on update now())"
    execute sql
  end

  def self.down
    drop_table :users
  end
end
