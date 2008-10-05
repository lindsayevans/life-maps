class AddFieldsToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :nick_name, :string
    add_column :users, :full_name, :string
    add_column :users, :website_url, :text
    add_column :users, :website_name, :string
    add_column :users, :permalink, :string
    add_column :users, :admin, :boolean, :default => false, :null => false
    add_column :users, :description, :text
  end

  def self.down
    remove_column :users, :nick_name
    remove_column :users, :full_name
    remove_column :users, :website_url
    remove_column :users, :website_name
    remove_column :users, :permalink
    remove_column :users, :admin
    remove_column :users, :description
  end
end
