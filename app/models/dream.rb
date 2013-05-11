# == Schema Information
#
# Table name: dreams
#
#  id                :integer          not null, primary key
#  description       :text             not null
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  context_tag_count :integer          default(0), not null
#  content_tag_count :integer          default(0), not null
#
# Indexes
#
#  index_dreams_on_content_tag_count  (content_tag_count)
#  index_dreams_on_context_tag_count  (context_tag_count)
#  index_dreams_on_created_at         (created_at)
#  index_dreams_on_updated_at         (updated_at)
#  index_dreams_on_user_id            (user_id)
#

class Dream < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :content_tags, :context_tags

  belongs_to :user

  default_scope order: 'dreams.created_at DESC'

  scope :recent, limit: 5
  scope :created_before, ->(max_date) {
    where('dreams.created_at <= ?', max_date.utc)
  }
  scope :created_since, ->(min_date) {
    where('dreams.created_at >= ?', min_date.utc)
  }

  scope :with_tag, ->(tag_name) { tagged_with(tag_name) }
  scope :with_content_tag, ->(tag_name) { tagged_with(tag_name, on: :content_tags) }
  scope :with_context_tag, ->(tag_name) { tagged_with(tag_name, on: :context_tags) }

  validates_presence_of :description

  before_save :update_tag_counts

  protected

  def update_tag_counts
    self.content_tag_count = self.content_tag_list.size
    self.context_tag_count = self.context_tag_list.size
  end
end
