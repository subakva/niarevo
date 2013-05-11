# == Schema Information
#
# Table name: dreams
#
#  id                :integer          not null, primary key
#  description       :text             not null
#  user_id           :integer
#  dreamer_tag_count :integer          default(0), not null
#  dream_tag_count   :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_dreams_on_created_at         (created_at)
#  index_dreams_on_dream_tag_count    (dream_tag_count)
#  index_dreams_on_dreamer_tag_count  (dreamer_tag_count)
#  index_dreams_on_updated_at         (updated_at)
#  index_dreams_on_user_id            (user_id)
#

class Dream < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :dream_tags, :dreamer_tags

  belongs_to :user

  default_scope -> { order('dreams.created_at DESC') }

  scope :recent, -> { limit(5) }
  scope :created_before, ->(max_date) {
    where('dreams.created_at <= ?', max_date.utc)
  }
  scope :created_since, ->(min_date) {
    where('dreams.created_at >= ?', min_date.utc)
  }

  scope :with_tag, ->(tag_name) { tagged_with(tag_name) }
  scope :with_dream_tag, ->(tag_name) { tagged_with(tag_name, on: :dream_tags) }
  scope :with_dreamer_tag, ->(tag_name) { tagged_with(tag_name, on: :dreamer_tags) }

  validates_presence_of :description

  before_save :update_tag_counts

  protected

  def update_tag_counts
    self.dream_tag_count = self.dream_tag_list.size
    self.dreamer_tag_count = self.dreamer_tag_list.size
  end
end
