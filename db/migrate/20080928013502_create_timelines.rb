class CreateTimelines < ActiveRecord::Migration
  def self.up
    create_table :timelines do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.string :friendly_url, :null => false
      t.string :map_api_key
      t.boolean :public, :default => true

      t.timestamps
    end

    add_index :timelines, :user_id
    add_index :timelines, :friendly_url
    add_index :timelines, :public

  end

  def self.down
    drop_table :timelines
  end
end
