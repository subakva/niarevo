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
  should_have_scope :with_tag, :with => 'the_tag', :joins => :tags, :conditions => { :tags => { :name => 'the_tag' } }
  should_have_scope :created_before,  :with => Time.local('2009'), :conditions => ['created_at <= ?', Time.local('2009')]
  should_have_scope :created_after,   :with => Time.local('2009'), :conditions => ['created_at >= ?', Time.local('2009')]

  should_allow_mass_assignment_of :description, :tag_list
  

  it "should be taggable" do
    @dream.tag_list = 'one, two, three'
    @dream.tag_list.should == ['one','two', 'three']
  end
end
