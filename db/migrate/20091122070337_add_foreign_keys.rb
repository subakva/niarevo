class AddForeignKeys < ActiveRecord::Migration
  def self.up
    add_foreign_key :dreams, :users, :dependent => :delete
    add_foreign_key :taggings, :tags, :dependent => :delete
  end

  def self.down
    remove_foreign_key :taggings, :tags
    remove_foreign_key :dreams, :users
  end
end
