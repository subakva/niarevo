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
#

require 'spec_helper'

describe Dream do
  let(:dreamer) { dream.user }
  let(:dream) { FactoryGirl.create(:dream, :untagged, description: 'my public dream') }

  describe '.visible_to' do
    let(:private_dream) { FactoryGirl.create(:dream, :private, user: dreamer, description: 'my private dream') }
    let(:public_dream) { FactoryGirl.create(:dream, description: 'other public dream') }
    let(:hidden_dream) { FactoryGirl.create(:dream, :private, description: 'other private dream') }

    let!(:visible_dreams) { [dream, public_dream, private_dream] }
    let!(:hidden_dreams) { [hidden_dream] }

    context 'for a user' do
      subject(:scope) { Dream.visible_to(dreamer) }

      it "includes another user's public dream" do
        expect(scope).to include(public_dream)
      end

      it "includes the user's private dream" do
        expect(scope).to include(private_dream)
      end

      it "includes the user's public dream" do
        expect(scope).to include(dream)
      end

      it "filters out other's private dreams" do
        expect(scope).to_not include(hidden_dream)
      end
    end

    context 'for an anoymous user' do
      subject(:scope) { Dream.visible_to(nil) }

      it 'includes all public dreams' do
        expect(scope).to include(dream)
        expect(scope).to include(public_dream)
      end

      it 'filters out all private dreams' do
        expect(scope).to_not include(hidden_dream)
        expect(scope).to_not include(private_dream)
      end
    end
  end

  describe 'tagging' do
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
