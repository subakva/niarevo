# frozen_string_literal: true

class AddPrivateFlagToDreams < ActiveRecord::Migration[4.2]
  def up
    add_column :dreams, :private, :boolean, null: false, default: false
    add_index :dreams, [:user_id, :private]
    remove_index :dreams, :user_id
  end

  def down
    remove_index :dreams, [:user_id, :private]
    remove_column :dreams, :private
    add_index :dreams, :user_id
  end
end
