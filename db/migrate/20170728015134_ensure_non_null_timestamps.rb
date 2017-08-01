# frozen_string_literal: true

class EnsureNonNullTimestamps < ActiveRecord::Migration[4.2]
  def change
    [
      :dreams,
      :invites,
      :taggings,
      :tags,
      :users,
    ].each do |table_name|
      change_column_null table_name, :created_at, false
      change_column_null table_name, :updated_at, false
    end
  end
end
