class AddIndexesToPlaces < ActiveRecord::Migration
  def self.up
    change_column :places, :coordinates, :point, :null => false
    add_index :places, :coordinates, :spatial => true
    add_index :places, :from_start
    add_index :places, :from_end
    add_index :places, :to_start
    add_index :places, :to_end
    add_index :places, :timeline_id
    add_index :places, :user_id
  end

  def self.down
    remove_index :places, :coordinates
    remove_index :places, :from_start
    remove_index :places, :from_end
    remove_index :places, :to_start
    remove_index :places, :to_end
    remove_index :places, :timeline_id
    remove_index :places, :user_id
  end
end
