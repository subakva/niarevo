require 'spec_helper'

describe Dream do
  describe 'tagging' do
    let(:dreamer) { dream.user }
    let(:dream) { FactoryGirl.create(:dream, :untagged) }

    before {
      dream.content_tag_list = ['one', 'two']
      dream.context_tag_list = ['one', 'two', 'three']
      dream.save!
      dream.reload
    }

    it 'saves tags' do
      dream.content_tag_list.sort.should == ['one', 'two'].sort
      dream.context_tag_list.sort.should == ['one', 'two', 'three'].sort
    end

    it 'updates the tag counts' do
      dream.content_tag_count.should == 2
      dream.context_tag_count.should == 3
    end
  end
end
