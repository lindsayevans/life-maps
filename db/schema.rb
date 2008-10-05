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

ActiveRecord::Schema.define(:version => 20081005034619) do

  create_table "avatars", :force => true do |t|
    t.integer  "temp_user_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identity_urls", :force => true do |t|
    t.integer  "user_id"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "timelines", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.string   "name",                           :null => false
    t.text     "description"
    t.string   "friendly_url",                   :null => false
    t.string   "map_api_key"
    t.boolean  "public",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timelines", ["user_id"], :name => "index_timelines_on_user_id"
  add_index "timelines", ["friendly_url"], :name => "index_timelines_on_friendly_url"
  add_index "timelines", ["public"], :name => "index_timelines_on_public"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "nick_name"
    t.string   "full_name"
    t.text     "website_url"
    t.string   "website_name"
    t.string   "permalink"
    t.boolean  "admin",                                    :default => false, :null => false
    t.text     "description"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
