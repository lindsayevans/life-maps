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

ActiveRecord::Schema.define(:version => 20081012005429) do

  create_table "avatars", :force => true do |t|
    t.column "temp_user_id", :integer
    t.column "user_id", :integer
    t.column "parent_id", :integer
    t.column "content_type", :string
    t.column "filename", :string
    t.column "thumbnail", :string
    t.column "size", :integer
    t.column "width", :integer
    t.column "height", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "identity_urls", :force => true do |t|
    t.column "user_id", :integer
    t.column "url", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.column "issued", :integer
    t.column "lifetime", :integer
    t.column "handle", :string
    t.column "assoc_type", :string
    t.column "server_url", :binary
    t.column "secret", :binary
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.column "timestamp", :integer, :null => false
    t.column "server_url", :string
    t.column "salt", :string, :null => false
  end

  create_table "place_types", :force => true do |t|
    t.column "name", :string
    t.column "colour", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "places", :options=>'ENGINE=MyISAM', :force => true do |t|
    t.column "timeline_id", :integer
    t.column "user_id", :integer
    t.column "place_type_id", :integer
    t.column "name", :string
    t.column "description", :text
    t.column "coordinates", :point, :null => false
    t.column "from_start", :date
    t.column "from_end", :date
    t.column "from_original", :string
    t.column "from_resolution", :string
    t.column "to_start", :date
    t.column "to_end", :date
    t.column "to_original", :string
    t.column "to_resolution", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "places", ["coordinates"], :name => "index_places_on_coordinates", :spatial=> true 
  add_index "places", ["from_start"], :name => "index_places_on_from_start"
  add_index "places", ["from_end"], :name => "index_places_on_from_end"
  add_index "places", ["to_start"], :name => "index_places_on_to_start"
  add_index "places", ["to_end"], :name => "index_places_on_to_end"
  add_index "places", ["timeline_id"], :name => "index_places_on_timeline_id"
  add_index "places", ["user_id"], :name => "index_places_on_user_id"

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string, :null => false
    t.column "data", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "timelines", :force => true do |t|
    t.column "user_id", :integer, :null => false
    t.column "name", :string, :null => false
    t.column "description", :text
    t.column "friendly_url", :string, :null => false
    t.column "map_api_key", :string
    t.column "public", :boolean, :default => true
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "timelines", ["user_id"], :name => "index_timelines_on_user_id"
  add_index "timelines", ["friendly_url"], :name => "index_timelines_on_friendly_url"
  add_index "timelines", ["public"], :name => "index_timelines_on_public"

  create_table "users", :force => true do |t|
    t.column "login", :string, :limit => 40
    t.column "name", :string, :limit => 100, :default => ""
    t.column "email", :string, :limit => 100
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "remember_token", :string, :limit => 40
    t.column "remember_token_expires_at", :datetime
    t.column "avatar_file_name", :string
    t.column "avatar_content_type", :string
    t.column "avatar_file_size", :integer
    t.column "nick_name", :string
    t.column "full_name", :string
    t.column "website_url", :text
    t.column "website_name", :string
    t.column "permalink", :string
    t.column "admin", :boolean, :default => false, :null => false
    t.column "description", :text
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
