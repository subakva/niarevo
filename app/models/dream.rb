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
  is_taggable :tags
  validates_presence_of :description
  belongs_to :user

  default_scope :order => 'created_at DESC'
  named_scope :recent, :limit => 5
  named_scope :with_tag, lambda { |tag_name| { :joins => :tags, :conditions => { :tags => { :name => tag_name } } } }
  named_scope :created_before, lambda { |max_date| { :conditions => ['created_at <= ?', max_date] } }
  named_scope :created_after, lambda { |min_date| { :conditions => ['created_at >= ?', min_date] } }

  attr_accessible :description, :tag_list
end
