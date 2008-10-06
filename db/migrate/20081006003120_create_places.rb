class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.integer :timeline_id
      t.integer :user_id
      t.string :name
      t.point :coordinates
      t.date :from_start
      t.date :from_end
      t.string :from_original
      t.string :from_resolution
      t.date :to_start
      t.date :to_end
      t.string :to_original
      t.string :to_resolution
      t.text :description
      t.integer :place_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
