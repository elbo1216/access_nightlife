# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110118061227) do

  create_table "event_requests", :force => true do |t|
    t.integer   "user_id"
    t.boolean   "has_contacted", :default => false
    t.integer   "event_id"
    t.timestamp "created_at",                       :null => false
    t.timestamp "updated_at",                       :null => false
  end

  create_table "events", :force => true do |t|
    t.integer   "flyer_id"
    t.string    "event_name",         :limit => 100
    t.datetime  "event_start_time"
    t.string    "event_address",      :limit => 50
    t.string    "event_notes1",       :limit => 50
    t.string    "event_notes2",       :limit => 50
    t.string    "event_notes3",       :limit => 50
    t.timestamp "created_at",                        :null => false
    t.timestamp "updated_at",                        :null => false
    t.string    "venue",              :limit => 50
    t.string    "event_notes1_label", :limit => 50
    t.string    "event_notes2_label", :limit => 50
    t.string    "event_notes3_label", :limit => 50
  end

  create_table "flyers", :force => true do |t|
    t.string    "filename",   :limit => 100
    t.string    "file_path"
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  create_table "newsletter_requests", :force => true do |t|
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "upcoming_events", :force => true do |t|
    t.integer   "event_id"
    t.string    "event_type",  :limit => 1
    t.timestamp "created_at",               :null => false
    t.timestamp "updated_at",               :null => false
    t.integer   "event_order"
  end

  create_table "users", :force => true do |t|
    t.string    "firstname",     :limit => 50
    t.string    "lastname",      :limit => 50
    t.string    "email",         :limit => 50
    t.string    "phone",         :limit => 10
    t.string    "birthday",      :limit => 8
    t.boolean   "is_admin_user"
    t.timestamp "created_at",                  :null => false
    t.timestamp "updated_at",                  :null => false
  end

end
