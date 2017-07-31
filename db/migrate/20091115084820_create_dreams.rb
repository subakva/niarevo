class CreateDreams < ActiveRecord::Migration[4.2]
  def self.up
    create_table :dreams do |t|
      t.text :description,  null: false
      t.integer :user_id,   null: true
      t.integer :context_tag_count, null: false, default: 0
      t.integer :content_tag_count, null: false, default: 0
      t.timestamps
    end
    add_index :dreams, :user_id
    add_index :dreams, :created_at
    add_index :dreams, :updated_at
    add_index :dreams, :content_tag_count
    add_index :dreams, :context_tag_count

    add_foreign_key :dreams, :users, dependent: :delete
  end

  def self.down
    remove_foreign_key :dreams, :users

    remove_index :dreams, :content_tag_count
    remove_index :dreams, :context_tag_count
    remove_index :dreams, :updated_at
    remove_index :dreams, :created_at
    remove_index :dreams, :user_id
    drop_table :dreams
  end
end
