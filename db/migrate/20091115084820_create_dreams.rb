class CreateDreams < ActiveRecord::Migration
  def self.up
    create_table :dreams do |t|
      t.text :description, :null => false
      t.integer :user_id, :null => true
      t.timestamps
    end
    add_index :dreams, :user_id
    add_index :dreams, :created_at
    add_index :dreams, :updated_at
  end

  def self.down
    remove_index :dreams, :updated_at
    remove_index :dreams, :created_at
    remove_index :dreams, :user_id
    drop_table :dreams
  end
end
