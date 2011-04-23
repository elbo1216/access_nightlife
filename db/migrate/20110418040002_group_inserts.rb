class GroupInserts < ActiveRecord::Migration
  def self.up
    sql = "INSERT INTO groups (name, group_key) VALUES ('Root', 'root');"
    execute sql
    sql = "INSERT INTO groups (name, group_key) VALUES ('Photographer', 'photographer');"
    execute sql
  end

  def self.down
  end
end
