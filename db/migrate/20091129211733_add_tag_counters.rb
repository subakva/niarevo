class AddTagCounters < ActiveRecord::Migration
  def self.up
    add_column :dreams, :context_tag_count, :integer, :null => false, :default => 0
    add_column :dreams, :content_tag_count, :integer, :null => false, :default => 0
    add_index :dreams, :content_tag_count
    add_index :dreams, :context_tag_count

    Dream.find_each do |dream|
      dream.context_tag_count = dream.context_tag_list.size
      dream.content_tag_count = dream.content_tag_list.size
      dream.save!
    end
  end

  def self.down
    remove_index :dreams, :context_tag_count
    remove_index :dreams, :content_tag_count
    remove_column :dreams, :content_tag_count
    remove_column :dreams, :context_tag_count
  end
end
