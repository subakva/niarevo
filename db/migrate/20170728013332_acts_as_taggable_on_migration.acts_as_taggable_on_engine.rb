# frozen_string_literal: true

class ActsAsTaggableOnMigration < ActiveRecord::Migration[4.2]
  def change
    add_column :tags, :taggings_count, :integer, default: 0

    remove_index :tags, name: 'idx_tags_by_name' # rubocop:disable Rails/ReversibleMigration
    add_index :tags, :name, unique: true

    add_index :taggings, :tag_id
    add_index :taggings, :taggable_id
    add_index :taggings, :taggable_type
    add_index :taggings, :tagger_id
    add_index :taggings, :context

    add_index :taggings, [:tagger_id, :tagger_type]
    add_index :taggings, [:taggable_id, :taggable_type, :tagger_id, :context],
              name: 'taggings_idy'
    add_index :taggings,
              [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type],
              unique: true,
              name: 'taggings_idx'
  end
end
