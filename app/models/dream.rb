class Dream < ActiveRecord::Base
  is_taggable :tags
  validates_presence_of :description
  belongs_to :user

  default_scope :order => 'created_at DESC'
  named_scope :with_tag, lambda { |tag_name| { :joins => :tags, :conditions => { :tags => { :name => tag_name } } } }
  named_scope :created_before, lambda { |max_date| { :conditions => ['created_at <= ?', max_date] } }
  named_scope :created_after, lambda { |min_date| { :conditions => ['created_at >= ?', min_date] } }
  
end
