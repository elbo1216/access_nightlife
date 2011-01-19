class CreateNewsletterRequests < ActiveRecord::Migration
  def self.up
	sql = "create table newsletter_requests(
             id         	integer not null auto_increment primary key,
			 user_id		integer references users(id),
             created_at 	timestamp default '0000-00-00 00:00:00',
             updated_at 	timestamp default now() on update now())"
    execute sql
  end

  def self.down
  end
end
