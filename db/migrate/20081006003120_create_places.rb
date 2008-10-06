class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.integer :timeline_id
      t.integer :user_id
      t.integer :place_type_id
      t.string :name
      t.text :description
      t.column :coordinates, :point # No sexy migrations for geometric types
      t.date :from_start
      t.date :from_end
      t.string :from_original
      t.string :from_resolution
      t.date :to_start
      t.date :to_end
      t.string :to_original
      t.string :to_resolution

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
