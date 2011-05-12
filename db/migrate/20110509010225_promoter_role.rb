class PromoterRole < ActiveRecord::Migration
  def self.up
    sql = "insert into groups (name, group_key) VALUES ('Promoter', 'promoter');"
    execute sql
  end

  def self.down
  end
end
