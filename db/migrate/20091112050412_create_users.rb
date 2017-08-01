# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
      t.string    :username,            null: false, limit: 32
      t.string    :email,               null: false
      t.string    :crypted_password,    null: false
      t.string    :password_salt,       null: false
      t.string    :persistence_token,   null: false
      t.string    :single_access_token, null: false
      t.string    :perishable_token,    null: false
      t.integer   :login_count,         null: false, default: 0
      t.integer   :failed_login_count,  null: false, default: 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip,     limit: 46
      t.string    :last_login_ip,        limit: 46
      t.boolean   :active,               null: false, default: false

      t.timestamps
    end

    add_index :users, :username,            unique: true
    add_index :users, :email,               unique: true
    add_index :users, :persistence_token,   unique: true
    add_index :users, :single_access_token, unique: true
    add_index :users, :perishable_token,    unique: true
  end

  def self.down
    remove_index :users, :perishable_token
    remove_index :users, :single_access_token
    remove_index :users, :persistence_token
    remove_index :users, :email
    remove_index :users, :username

    drop_table :users
  end
end
