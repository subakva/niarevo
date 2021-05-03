# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Authenticated Dreams" do
  let(:user) { FactoryBot.create(:user) }

  let(:dream_attributes) { FactoryBot.attributes_for(:dream, :anonymous) }
  let(:dream_text)    { dream_attributes[:description] }
  let(:dream_tags)    { dream_attributes[:dream_tags] }
  let(:dreamer_tags)  { dream_attributes[:dreamer_tags] }

  it 'adding a dream' do
    sign_in_as user

    visit new_dream_path

    expect(page).not_to include_recaptcha

    within('#new_dream') do
      fill_in 'Describe Your Dream',        with: dream_text
      fill_in 'Dream Tags',                 with: dream_tags.join(',')
      fill_in 'Dreamer Tags',               with: dreamer_tags.join(',')
      click_on 'Save'
    end

    expect(page).to have_current_path(dream_path(Dream.first), ignore_query: true)

    expect(page).to display_dreamer_name(user.username)
    expect(page).to display_dream_text(dream_text)
    expect(page).to display_dream_tags(dream_tags)
    expect(page).to display_dreamer_tags(dreamer_tags)
  end
end
