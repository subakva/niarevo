require 'spec_helper'

describe Dream do
  describe 'tagging' do
    let(:dreamer) { dream.user }
    let(:dream) { FactoryGirl.create(:dream, :untagged) }

    before {
      dream.dream_tag_list = ['one', 'two']
      dream.dreamer_tag_list = ['one', 'two', 'three']
      dream.save!
      dream.reload
    }

    it 'saves tags' do
      dream.dream_tag_list.sort.should == ['one', 'two'].sort
      dream.dreamer_tag_list.sort.should == ['one', 'two', 'three'].sort
    end

    it 'updates the tag counts' do
      dream.dream_tag_count.should == 2
      dream.dreamer_tag_count.should == 3
    end
  end
end
