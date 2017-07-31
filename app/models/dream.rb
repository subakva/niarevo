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
#  private           :boolean          default(FALSE), not null
#  dream_tags        :string           default([]), not null, is an Array
#  dreamer_tags      :string           default([]), not null, is an Array
#
# Indexes
#
#  index_dreams_on_created_at           (created_at)
#  index_dreams_on_dream_tag_count      (dream_tag_count)
#  index_dreams_on_dream_tags           (dream_tags)
#  index_dreams_on_dreamer_tag_count    (dreamer_tag_count)
#  index_dreams_on_dreamer_tags         (dreamer_tags)
#  index_dreams_on_updated_at           (updated_at)
#  index_dreams_on_user_id_and_private  (user_id,private)
#
# Foreign Keys
#
#  dreams_user_id_fk  (user_id => users.id) ON DELETE => cascade
#

class Dream < ApplicationRecord
  belongs_to :user, optional: true

  default_scope -> { order("#{table_name}.created_at DESC") }

  scope :newest_first, -> { reorder("#{table_name}.created_at DESC") }
  scope :recent, -> { newest_first.limit(5) }
  scope :created_before, ->(max_date) { where('dreams.created_at <= ?', max_date.utc) }
  scope :created_since, ->(min_date) { where('dreams.created_at >= ?', min_date.utc) }

  scope :not_private, -> { where(private: false) }
  scope :visible_to, (lambda do |user|
    if user.nil?
      where(private: false)
    else
      where(private: false).or(where(user_id: user.id))
    end
  end)
  scope :with_tag, ->(tag_name) { with_dream_tag(tag_name).or(with_dreamer_tag(tag_name)) }
  scope :with_dream_tag, (lambda do |tag_name|
    tag_name = normalize_tag_name(tag_name)
    where("'#{tag_name}' = ANY (#{table_name}.dream_tags)")
  end)
  scope :with_dreamer_tag, (lambda do |tag_name|
    tag_name = normalize_tag_name(tag_name)
    where("'#{tag_name}' = ANY (#{table_name}.dreamer_tags)")
  end)

  before_validation :normalize_tags
  validates :description, presence: true

  before_save :update_tag_counts

  def joined_dream_tags
    dream_tags.join(', ')
  end

  def joined_dream_tags=(value)
    self.dream_tags = Dream.normalize_joined_tags(value)
  end

  def joined_dreamer_tags
    dreamer_tags.join(', ')
  end

  def joined_dreamer_tags=(value)
    self.dreamer_tags = Dream.normalize_joined_tags(value)
  end

  class << self
    def normalize_joined_tags(joined_tags)
      normalize_tag_list(joined_tags.to_s.split(/,/))
    end

    def normalize_tag_list(tag_list)
      tag_list ||= []
      tag_list.map { |t| normalize_tag_name(t) }.reject(&:blank?).uniq.sort
    end

    def normalize_tag_name(tag_name)
      tag_name.to_s.strip.downcase.parameterize
    end
  end

  protected

  def normalize_tags
    self.dream_tags = Dream.normalize_tag_list(dream_tags)
    self.dreamer_tags = Dream.normalize_tag_list(dreamer_tags)
  end

  def update_tag_counts
    self.dream_tag_count = dream_tags.size
    self.dreamer_tag_count = dreamer_tags.size
  end
end
