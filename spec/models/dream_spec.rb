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

  describe 'tag counts' do
    before(:each) do
      @dream = Factory.create(:dream,
        :content_tag_list => '',
        :context_tag_list => ''
      )
    end

    it "updates the tag count before saving" do
      @dream.content_tag_count.should == 0
      @dream.context_tag_count.should == 0

      @dream.content_tag_list = 'one, two, three'
      @dream.context_tag_list = 'uno, dos'
      @dream.save!

      @dream.content_tag_count.should == 3
      @dream.context_tag_count.should == 2

      @dream.content_tag_list = 'one, two'
      @dream.context_tag_list = 'uno'
      @dream.save!

      @dream.content_tag_count.should == 2
      @dream.context_tag_count.should == 1
    end
  end

  describe 'tag kinds' do
    before(:each) do
      @dream = Factory.create(:dream)
    end

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

  describe 'associating tags with a user' do
    before(:each) do
      @dreamer = Factory.create(:user, :username => 'dreamer')
      @tagger = Factory.create(:user, :username => 'tagger')
      @preexisting_content_tag = Tag.create(:name => 'preexisting_content', :kind => 'content_tag')
      @preexisting_context_tag = Tag.create(:name => 'preexisting_context', :kind => 'context_tag')
      @dream = Factory.build(:dream,
        :user => @dreamer,
        :content_tag_list => 'preexisting_content, new_dream_content',
        :context_tag_list => 'preexisting_context, new_dream_context'
      )
    end

    it "associates new taggings on an existing dream with the dream tagger" do
      @dream.save!

      @dream.tagged_by = @tagger
      @dream.content_tag_list = @dream.content_tag_list + ['addon_content']
      @dream.context_tag_list = @dream.context_tag_list + ['addon_context']
      @dream.save!
      @dream.taggings.each do |tagging|
        if ['addon_content', 'addon_context'].include?(tagging.tag.name)
          tagging.user.should == @tagger
        else
          tagging.user.should == @dreamer
        end
      end
    end

    it "associates taggings on a new dream with the dream creator" do
      @dream.save!
      @dream.taggings.each do |tagging|
        tagging.user.should == @dreamer
      end
    end

    it "associates new tags on a new dream with the dream creator" do
      @dream.save!
      ['new_dream_content', 'new_dream_context'].should be_associated_with_user(@dreamer)
    end

    it "does not change the user association for a tag that already existed" do
      @dream.save!
      ['new_dream_content', 'new_dream_context'].should be_associated_with_user(@dreamer)
      ['preexisting_content', 'preexisting_context'].should be_associated_with_user(nil)
    end

    it "associates new tags on an existing dream with the dream tagger" do
      @dream.save!
      @dream.tagged_by = @tagger
      @dream.content_tag_list = @dream.content_tag_list + ['addon_content']
      @dream.context_tag_list = @dream.context_tag_list + ['addon_context']
      @dream.save!
      ['new_dream_content', 'new_dream_context'].should be_associated_with_user(@dreamer)
      ['preexisting_content', 'preexisting_context'].should be_associated_with_user(nil)
      ['addon_content', 'addon_context'].should be_associated_with_user(@tagger)
    end
  end
end
