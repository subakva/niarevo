# frozen_string_literal: true

class AddDreamTagArrays < ActiveRecord::Migration[5.1]
  def change
    change_table :dreams do |t|
      t.string :dream_tags, null: false, array: true, default: []
      t.index :dream_tags, using: 'gin'

      t.string :dreamer_tags, null: false, array: true, default: []
      t.index :dreamer_tags, using: 'gin'
    end
  end
end
