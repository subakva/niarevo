class AddActiveFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :state
  end
end
