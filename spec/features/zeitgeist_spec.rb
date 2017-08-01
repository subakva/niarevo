# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Zeitgeist' do
  context 'with no tagged dreams' do
    scenario 'displays untagged links' do
      visit zeitgeist_path

      within('#zeitgeist-overall .tag-cloud') do
        expect(page).to have_link('untagged', href: untagged_dreams_path)
      end

      within('#zeitgeist-today .tag-cloud') do
        expect(page).to have_link('untagged', href: untagged_dreams_path)
      end
    end
  end

  context 'with tagged dreams' do
    let!(:yesterday1) do
      FactoryGirl.create(:dream,
        dream_tags: %w[yesterday-dream common-dream],
        dreamer_tags: %w[yesterday-dreamer common-dreamer],
        created_at: 25.hours.ago
      )
    end

    let!(:yesterday2) do
      FactoryGirl.create(:dream,
        dream_tags: %w[yesterday-dream common-dream],
        dreamer_tags: %w[yesterday-dreamer common-dreamer],
        created_at: 25.hours.ago
      )
    end

    let!(:today1) do
      FactoryGirl.create(:dream,
        dream_tags: %w[b-obscure-dream today1-dream today-shared-dream common-dream],
        dreamer_tags: %w[b-obscure-dreamer today1-dreamer today-shared-dreamer common-dreamer],
        created_at: 1.hour.ago
      )
    end

    let!(:today2) do
      FactoryGirl.create(:dream,
        dream_tags: %w[a-obscure-dream today2-dream today-shared-dream common-dream],
        dreamer_tags: %w[a-obscure-dreamer today2-dreamer today-shared-dreamer common-dreamer],
        created_at: 1.hour.ago
      )
    end

    scenario 'tag clouds are displayed with popular tags' do
      visit zeitgeist_path

      within('#zeitgeist-today .tag-cloud') do
        expect(page).to have_tag_link('common-dream')
        expect(page).to have_tag_link('common-dreamer')
        expect(page).to have_tag_link('today-shared-dream')
        expect(page).to have_tag_link('today-shared-dreamer')
        expect(page).to have_tag_link('today1-dream')
        expect(page).to have_tag_link('today1-dreamer')
        expect(page).to have_tag_link('today2-dream')
        expect(page).to have_tag_link('today2-dreamer')
        expect(page).to have_tag_link('b-obscure-dream')
        expect(page).to have_tag_link('b-obscure-dreamer')

        # Limited to 10 tags, ordered by count DESC, tag DESC
        expect(page).to_not have_tag_link('a-obscure-dream')
        expect(page).to_not have_tag_link('a-obscure-dreamer')

        # Excludes dreams older than 24 hours
        expect(page).to_not have_tag_link('yesterday-dream')
        expect(page).to_not have_tag_link('yesterday-dreamer')
      end

      within('#zeitgeist-overall .tag-cloud') do
        expect(page).to have_tag_link('common-dream')
        expect(page).to have_tag_link('common-dreamer')
        expect(page).to have_tag_link('today-shared-dream')
        expect(page).to have_tag_link('today-shared-dreamer')
        expect(page).to have_tag_link('yesterday-dream')
        expect(page).to have_tag_link('yesterday-dreamer')
        expect(page).to have_tag_link('today1-dream')
        expect(page).to have_tag_link('today1-dreamer')
        expect(page).to have_tag_link('today2-dream')
        expect(page).to have_tag_link('today2-dreamer')

        # Limited to 10 tags, ordered by count DESC, tag DESC
        expect(page).to_not have_tag_link('a-obscure-dream')
        expect(page).to_not have_tag_link('a-obscure-dreamer')
      end
    end
  end
end
