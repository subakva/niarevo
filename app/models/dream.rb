class Dream < ActiveRecord::Base
  is_taggable :tags
  validates_presence_of :description
  belongs_to :user
end
