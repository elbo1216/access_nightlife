class CreateFlyers < ActiveRecord::Migration
  def self.up
	sql = "CREATE TABLE flyers (
				id			integer not null auto_increment primary key,
				filename	varchar(100),
				file_path	varchar(255),
				created_at	timestamp default '0000-00-00 00:00:00',
				updated_at	timestamp default now() on update now()
			)"
	execute(sql)
  end

  def self.down
  end
end
