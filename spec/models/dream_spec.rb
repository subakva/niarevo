require 'spec_helper'

describe Dream do
  describe 'tagging' do
    let(:dreamer) { dream.user }
    let(:dream) { FactoryGirl.create(:dream, :untagged) }

    before do
      dream.dream_tag_list = ['one', 'two']
      dream.dreamer_tag_list = ['one', 'two', 'three']
      dream.save!
      dream.reload
    end

    it 'saves tags' do
      expect(dream.dream_tag_list.sort).to eq(['one', 'two'].sort)
      expect(dream.dreamer_tag_list.sort).to eq(['one', 'two', 'three'].sort)
    end

    it 'updates the tag counts' do
      expect(dream.dream_tag_count).to eq(2)
      expect(dream.dreamer_tag_count).to eq(3)
    end
  end
end
