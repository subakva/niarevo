class AddLengthLimitsToTags < ActiveRecord::Migration
  def self.up
    change_column :tags, :name, :string, :null => false, :limit => 64
    change_column :tags, :kind, :string, :null => false, :limit => 32
  end

  def self.down
    change_column :tags, :kind, :string, :null => false
    change_column :tags, :name, :string, :null => false
  end
end
