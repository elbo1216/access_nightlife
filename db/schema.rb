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

ActiveRecord::Schema.define(:version => 20111127232852) do

  create_table "affiliates", :force => true do |t|
    t.string    "affiliate_name"
    t.string    "img_filename",   :limit => 100
    t.string    "img_file_path"
    t.boolean   "is_active",                     :default => false
    t.timestamp "created_at",                                       :null => false
    t.timestamp "updated_at",                                       :null => false
  end

  create_table "contact_requests", :force => true do |t|
    t.integer   "user_id"
    t.boolean   "has_contacted",                :default => false, :null => false
    t.string    "contacted_by",  :limit => 100
    t.text      "comments"
    t.timestamp "created_at",                                      :null => false
    t.timestamp "updated_at",                                      :null => false
  end

  create_table "event_requests", :force => true do |t|
    t.integer   "user_id"
    t.date      "event_date_requested"
    t.string    "event_for",            :limit => 100
    t.integer   "number_of_ladies"
    t.integer   "number_of_men"
    t.string    "bottle_service",       :limit => 100
    t.string    "city",                 :limit => 100
    t.string    "neighborhood",         :limit => 100
    t.string    "preferred_venue",      :limit => 100
    t.text      "comments"
    t.boolean   "has_contacted",                       :default => false, :null => false
    t.string    "contacted_by",         :limit => 100
    t.integer   "event_id"
    t.timestamp "created_at",                                             :null => false
    t.timestamp "updated_at",                                             :null => false
  end

  create_table "events", :force => true do |t|
    t.integer   "flyer_id"
    t.string    "event_venue",             :limit => 50
    t.string    "event_venue_styles",      :limit => 50
    t.string    "event_name",              :limit => 100
    t.string    "event_name_styles",       :limit => 50
    t.time      "event_start_time"
    t.string    "event_start_time_styles", :limit => 50
    t.date      "event_start_date"
    t.string    "event_start_date_styles", :limit => 50
    t.string    "event_address",           :limit => 50
    t.string    "event_address_styles",    :limit => 50
    t.string    "event_notes1_label",      :limit => 50
    t.string    "event_notes1",            :limit => 50
    t.string    "event_notes1_styles",     :limit => 50
    t.string    "event_notes2_label",      :limit => 50
    t.string    "event_notes2",            :limit => 50
    t.string    "event_notes2_styles",     :limit => 50
    t.string    "event_notes3_label",      :limit => 50
    t.string    "event_notes3",            :limit => 50
    t.string    "event_notes3_styles",     :limit => 50
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
  end

  create_table "flyers", :force => true do |t|
    t.string    "filename",   :limit => 100
    t.string    "file_path"
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  create_table "galleries", :force => true do |t|
    t.string    "name"
    t.string    "description_short",    :limit => 50
    t.string    "description_long"
    t.integer   "event_id"
    t.string    "gallery_path"
    t.integer   "gallery_logo_id"
    t.boolean   "is_current_slideshow",               :default => false
    t.boolean   "is_feature_gallery",                 :default => false
    t.timestamp "created_at",                                            :null => false
    t.timestamp "updated_at",                                            :null => false
  end

  create_table "gallery_images", :force => true do |t|
    t.integer   "gallery_id",                                           :null => false
    t.string    "image_path",                                           :null => false
    t.string    "image_filename",                                       :null => false
    t.string    "image_comments",     :limit => 100
    t.boolean   "is_slideshow_image",                :default => false, :null => false
    t.boolean   "is_media_image",                    :default => false
    t.timestamp "created_at",                                           :null => false
    t.timestamp "updated_at",                                           :null => false
  end

  create_table "gallery_logos", :force => true do |t|
    t.string    "logo_path"
    t.string    "logo_file_name"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  create_table "groups", :force => true do |t|
    t.string    "name"
    t.string    "group_key",  :limit => 100
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
  end

  create_table "music_files", :force => true do |t|
    t.string    "filename",   :limit => 100
    t.string    "file_path"
    t.boolean   "is_active",                 :default => false
    t.timestamp "created_at",                                   :null => false
    t.timestamp "updated_at",                                   :null => false
  end

  create_table "newsletter_requests", :force => true do |t|
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "social_media_accounts", :force => true do |t|
    t.string    "media_name"
    t.string    "media_url",  :limit => 2000
    t.timestamp "created_at",                 :null => false
    t.timestamp "updated_at",                 :null => false
  end

  create_table "upcoming_events", :force => true do |t|
    t.integer   "event_id"
    t.string    "event_type",  :limit => 1, :null => false
    t.integer   "event_order"
    t.timestamp "created_at",               :null => false
    t.timestamp "updated_at",               :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.integer   "user_id"
    t.integer   "group_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "firstname"
    t.string    "lastname"
    t.string    "email"
    t.string    "phone",              :limit => 10
    t.string    "birthday",           :limit => 8
    t.boolean   "is_admin_user"
    t.string    "crypted_password"
    t.string    "password_salt"
    t.string    "persistence_token"
    t.integer   "login_count"
    t.integer   "failed_login_count"
    t.datetime  "current_login_at"
    t.datetime  "last_login_at"
    t.string    "current_login_ip",   :limit => 100
    t.string    "last_login_ip",      :limit => 100
    t.timestamp "created_at",                        :null => false
    t.timestamp "updated_at",                        :null => false
  end

end
