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

require File.dirname(__FILE__) + '/../spec_helper'

describe Dream do
  before(:each) do
    @dream = Factory.create(:dream)
  end

  should_validate_presence_of :description
  should_belong_to :user
  should_have_default_scope :order => 'created_at DESC'
  should_have_scope :recent, :limit => 5
  should_have_scope :created_before,  :with => Time.local('2009'), :conditions => ['created_at <= ?', Time.local('2009')]
  should_have_scope :created_after,   :with => Time.local('2009'), :conditions => ['created_at >= ?', Time.local('2009')]
  should_have_scope :with_tag, :with => 'the_tag', :joins => :tags,
    :conditions => { :tags => { :name => 'the_tag' } }
  should_have_scope :with_content_tag, :with => 'the_content_tag', :joins => :tags,
    :conditions => { :tags => { :name => 'the_content_tag', :kind => 'content_tag' } }
  should_have_scope :with_context_tag, :with => 'the_context_tag', :joins => :tags,
    :conditions => { :tags => { :name => 'the_context_tag', :kind => 'context_tag' } }

  should_allow_mass_assignment_of :description, :content_tag_list, :context_tag_list

  it "should make all tags accessible as a single list" do
    @dream.content_tag_list = 'one, two, three'
    @dream.context_tag_list = 'uno, dos, tres'
    @dream.tag_list.should == ['one','two', 'three', 'uno','dos', 'tres']
  end

  it "should be taggable for dreams" do
    @dream.content_tag_list = 'one, two, three'
    @dream.content_tag_list.should == ['one','two', 'three']
  end

  it "should be taggable for context" do
    @dream.context_tag_list = 'uno, dos, tres'
    @dream.context_tag_list.should == ['uno','dos', 'tres']
  end
end
