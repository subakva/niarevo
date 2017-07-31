class TaggableMigration < ActiveRecord::Migration[4.2]
  def self.up
    create_table :tags do |t|
      t.string :name, null: false, limit: 64
      t.timestamps
    end
    add_index :tags, :name, name: 'idx_tags_by_name'

    create_table :taggings do |t|
      t.integer :tag_id, null: false

      t.integer :taggable_id, null: false
      t.string :taggable_type, null: false, limit: 32
      t.string :context, limit: 32

      t.integer :tagger_id, null: true
      t.string :tagger_type, null: true, limit: 32

      t.timestamps
    end

    add_index :taggings, [:taggable_id, :taggable_type, :context],
      name: 'idx_taggings_by_taggable'
    add_index :taggings, [:tagger_id, :tagger_type, :context],
      name: 'idx_taggings_by_tagger'
    add_index :taggings, [:tag_id, :context],
      name: 'idx_taggings_by_tags'

    add_foreign_key :taggings, :tags, dependent: :delete
  end

  def self.down
    remove_foreign_key :taggings, :tags

    remove_index :taggings, name: 'idx_taggings_by_tags'
    remove_index :taggings, name: 'idx_taggings_by_tagger'
    remove_index :taggings, name: 'idx_taggings_by_taggable'
    drop_table :taggings

    remove_index :tags, name: 'idx_tags_by_name'
    drop_table :tags
  end
end
