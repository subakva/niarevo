class UpdateTagKindForDreams < ActiveRecord::Migration
  def self.up
    Tag.update_all("kind = 'dream_tag'", "kind = 'tag'")
  end

  def self.down
    Tag.update_all("kind = 'tag'", "kind = 'dream_tag'")
  end
end
