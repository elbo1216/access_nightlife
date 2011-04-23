class Groups < ActiveRecord::Migration
  def self.up
    sql = "CREATE TABLE groups (
             id         integer not null auto_increment primary key,
             name       varchar(255),
             group_key        varchar(100),
             created_at timestamp default '0000-00-00 00:00:00',
             updated_at timestamp default now() on update now());
           "
    execute sql
  end

  def self.down
    drop_table :groups
  end
end
