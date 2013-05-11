class ChangeTagNames < ActiveRecord::Migration
  def up
    rename_column :dreams, :context_tag_count, :dreamer_tag_count
    rename_column :dreams, :content_tag_count, :dream_tag_count

    remove_index :dreams, :content_tag_count
    add_index :dreams, :dream_tag_count

    remove_index :dreams, :context_tag_count
    add_index :dreams, :dreamer_tag_count

    execute %{UPDATE taggings SET context = 'dreamer_tags' WHERE context = 'context_tags'}
    execute %{UPDATE taggings SET context = 'dream_tags'   WHERE context = 'content_tags'}
  end

  def down
    rename_column :dreams, :dreamer_tag_count, :context_tag_count
    rename_column :dreams, :dream_tag_count, :content_tag_count

    add_index :dreams, :content_tag_count
    remove_index :dreams, :dream_tag_count

    add_index :dreams, :context_tag_count
    remove_index :dreams, :dreamer_tag_count

    execute %{UPDATE taggings SET context = 'context_tags' WHERE context = 'dreamer_tags'}
    execute %{UPDATE taggings SET context = 'content_tags' WHERE context = 'dream_tags'}
  end
end
