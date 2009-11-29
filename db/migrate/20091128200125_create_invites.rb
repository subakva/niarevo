class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.string    :message,         :null => true,  :limit => 255
      t.string    :recipient_name,  :null => false, :limit => 32
      t.string    :email,           :null => false, :limit => 100
      t.integer   :user_id,         :null => false
      t.timestamp :sent_at,         :null => true
      t.timestamps
    end
    add_index :invites, :email
    add_index :invites, :user_id
    add_index :invites, :created_at
    add_index :invites, [:email, :user_id], :unique => true
    add_index :invites, :sent_at
    add_foreign_key :invites, :users, :dependent => :delete
  end

  def self.down
    remove_foreign_key :invites, :users
    remove_index :invites, :sent_at
    remove_index :invites, :column => [:email, :user_id]
    remove_index :invites, :created_at
    remove_index :invites, :user_id
    remove_index :invites, :email
    drop_table :invites
  end
end
