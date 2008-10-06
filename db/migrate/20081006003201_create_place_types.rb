class CreatePlaceTypes < ActiveRecord::Migration
  def self.up
    create_table :place_types do |t|
      t.string :name
      t.string :colour

      t.timestamps
    end
  end

  def self.down
    drop_table :place_types
  end
end
