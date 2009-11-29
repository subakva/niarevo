# == Schema Information
#
# Table name: dreams
#
#  id          :integer(4)      not null, primary key
#  description :text            default(""), not null
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Dream < ActiveRecord::Base
  is_taggable :content_tags, :context_tags
  include TaggableByUser

  validates_presence_of :description
  belongs_to :user

  default_scope :order => 'created_at DESC'
  named_scope :recent, :limit => 5
  named_scope :created_before, lambda { |max_date| { :conditions => ['created_at <= ?', max_date] } }
  named_scope :created_after, lambda { |min_date| { :conditions => ['created_at >= ?', min_date] } }

  named_scope :with_tag, lambda { |tag_name| { :joins => :tags, :conditions => { :tags => { :name => tag_name } } } }
  named_scope :with_content_tag, lambda { |tag_name| { :joins => :tags,
    :conditions => { :tags => { :name => tag_name, :kind => 'content_tag' } }
  }}
  named_scope :with_context_tag, lambda { |tag_name| { :joins => :tags,
    :conditions => { :tags => { :name => tag_name, :kind => 'context_tag' } }
  }}

  attr_accessible :description, :content_tag_list, :context_tag_list

  attr_accessor :tagged_by
  before_validation_on_create :set_tagged_by_to_user
  before_save :update_tag_counts

  def tag_list
    self.content_tag_list + self.context_tag_list
  end

  protected
  def set_tagged_by_to_user
    self.tagged_by ||= self.user
  end

  def update_tag_counts
    self.content_tag_count = self.content_tag_list.size
    self.context_tag_count = self.context_tag_list.size
  end
end
