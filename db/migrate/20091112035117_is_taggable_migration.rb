class IsTaggableMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name, :null => false
      t.string :kind, :null => false
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_id,        :null => false
      t.string  :taggable_type, :null => false
      t.integer :taggable_id,   :null => false
      t.timestamps
    end
    
    add_index :tags,     [:name, :kind]
    add_index :tags, :created_at
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, [:tag_id, :taggable_type, :taggable_id], :unique => true
    add_index :taggings, :created_at
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
