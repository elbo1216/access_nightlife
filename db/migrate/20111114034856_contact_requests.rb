class ContactRequests < ActiveRecord::Migration
  def self.up
    sql = "create table contact_requests (
            id                       integer not null auto_increment primary key,
            user_id                  integer,
            has_contacted	           boolean not null default false,
            contacted_by             varchar(100),
            comments                 text,
            created_at timestamp     default '0000-00-00 00:00:00',
            updated_at timestamp     default now() on update now()
           )"
   execute sql
  end

  def self.down
    drop_table :contact_requests
  end
end
