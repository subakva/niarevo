# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Dream Editing" do
  let(:user) { FactoryBot.create(:user) }
  let!(:dream) { FactoryBot.create(:dream, user: user) }
  let(:new_dream_text) { 'Simply sanitizing the sullen snooge is sufficient.' }
  let(:new_dream_tags) { %w[sausage blitzkrieg] }
  let(:new_dreamer_tags) { %w[mines jupiter] }

  scenario 'editing a dream' do
    sign_in_as user

    visit dream_path(dream)
    click_link '[Edit]'
    ensure_on edit_dream_path(dream)

    expect(page).to_not include_recaptcha
    within('.edit-dream') do
      fill_in 'Describe Your Dream', with: ''
      fill_in 'Dream Tags',          with: ''
      fill_in 'Dreamer Tags',        with: ''
      click_on 'Save'
    end
    expect(page).to display_form_error("Description can't be blank")

    within('.edit-dream') do
      fill_in 'Describe Your Dream', with: new_dream_text
      fill_in 'Dream Tags',          with: new_dream_tags.join(',')
      fill_in 'Dreamer Tags',        with: new_dreamer_tags.join(',')
      click_on 'Save'
    end

    expect(current_path).to eq(dream_path(dream))
    expect(page).to display_dream_text(new_dream_text)
    expect(page).to display_dream_tags(new_dream_tags)
    expect(page).to display_dreamer_tags(new_dreamer_tags)
  end

  scenario "trying to edit someone else's dream" do
    sign_in_as FactoryBot.create(:user)

    visit edit_dream_path(dream)

    expect(current_path).to eq(root_path)
    expect(page).to display_alert('You are not allowed to edit that dream.')
  end
end
