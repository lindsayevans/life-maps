class CreateIdentityUrls < ActiveRecord::Migration
  def self.up
    create_table :identity_urls do |t|
      t.integer :user_id
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :identity_urls
  end
end
