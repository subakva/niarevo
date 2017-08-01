# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Dream Preview", js: true do
  let(:user) { FactoryGirl.create(:user) }

  let(:dream_attributes) { FactoryGirl.attributes_for(:dream, :anonymous) }
  let(:dream_text)    { dream_attributes[:description] }
  let(:dream_tags)    { dream_attributes[:dream_tags] }
  let(:dreamer_tags)  { dream_attributes[:dreamer_tags] }

  scenario 'previewing a dream' do
    sign_in_as user
    ensure_on new_dream_path

    within('#new_dream') do
      fill_in 'Describe Your Dream',        with: dream_text
      fill_in 'Dream Tags',                 with: dream_tags.join(',')
      fill_in 'Dreamer Tags',               with: dreamer_tags.join(',')

      first(:link, 'Preview').click
    end

    expect(current_path).to eq(new_dream_path)

    within('.preview-content article') do
      expect(page).to display_dreamer_name(user.username)
      expect(page).to display_dream_text(dream_text)
      expect(page).to display_dream_tags(dream_tags)
      expect(page).to display_dreamer_tags(dreamer_tags)
    end
  end
end
