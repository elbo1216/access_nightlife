class CreateAffiliate < ActiveRecord::Migration
  def self.up
	   sql = "CREATE TABLE affiliates (
				  id			          integer not null auto_increment primary key,
      affiliate_name  varchar(255),
				  img_filename	  varchar(100),
				  img_file_path	 varchar(255),
      is_active      boolean default false,
				  created_at	    timestamp default '0000-00-00 00:00:00',
				  updated_at	    timestamp default now() on update now()
			  )"
	   execute(sql)
  end

  def self.down
   sql = 'drop table affiliates;'
   execute(sql)
  end
end
