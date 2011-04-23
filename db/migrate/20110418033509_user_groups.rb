class UserGroups < ActiveRecord::Migration
  def self.up
    sql = "CREATE TABLE user_groups(
             id         integer not null auto_increment primary key,
             user_id    integer references users(id),
             group_id   integer references groups(id),
             created_at timestamp default '0000-00-00 00:00:00',
             updated_at timestamp default now() on update now())"
    execute sql 
  end

  def self.down
    drop_table :user_groups
  end
end
