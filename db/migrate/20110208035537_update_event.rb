class UpdateEvent < ActiveRecord::Migration
  def self.up
    sql = "alter table events add column event_start_date date"
    execute sql
    sql = "alter table events change event_start_time event_start_time time"
    execute sql

  end

  def self.down
  end
end
