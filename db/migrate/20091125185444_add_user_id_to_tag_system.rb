class AddUserIdToTagSystem < ActiveRecord::Migration
  def self.up
    add_column :tags, :user_id, :integer
    add_column :taggings, :user_id, :integer
    add_index :tags, :user_id
    add_index :taggings, :user_id
  end

  def self.down
    remove_index :taggings, :user_id
    remove_index :tags, :user_id
    remove_column :taggings, :user_id
    remove_column :tags, :user_id
  end
end
