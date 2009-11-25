class UpdateTagKindForDreams < ActiveRecord::Migration
  def self.up
    Tag.update_all("kind = 'content_tag'", "kind = 'tag'")
  end

  def self.down
    Tag.update_all("kind = 'tag'", "kind = 'content_tag'")
  end
end
