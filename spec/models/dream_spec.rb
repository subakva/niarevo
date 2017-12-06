# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dream do
  let(:dreamer) { dream.user }
  let(:dream) { FactoryBot.create(:dream, :untagged, description: 'my public dream') }

  describe '.visible_to' do
    let(:private_dream) do
      FactoryBot.create(:dream, :private, user: dreamer, description: 'my private dream')
    end
    let(:public_dream) { FactoryBot.create(:dream, description: 'other public dream') }
    let(:hidden_dream) { FactoryBot.create(:dream, :private, description: 'other private dream') }

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
      dream.joined_dream_tags = ' ONE, two , two'
      dream.joined_dreamer_tags = 'one, two by two, three'
      dream.save!
      dream.reload
    end

    it 'saves tags' do
      expect(dream.dream_tags).to eq(%w[one two].sort)
      expect(dream.dreamer_tags).to eq(%w[one two-by-two three].sort)
    end

    it 'updates the tag counts' do
      expect(dream.dream_tag_count).to eq(2)
      expect(dream.dreamer_tag_count).to eq(3)
    end
  end
end
