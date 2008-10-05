class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.integer :temp_user_id
      t.integer :user_id
      t.integer :parent_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
