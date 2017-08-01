# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Static Pages' do
  scenario 'static pages are accessible' do
    visit root_path

    within('footer') { click_on 'About' }
    expect(current_path).to eq(about_path)
    expect(page).to have_content('What is this?')

    within('footer') { click_on 'Feeds' }
    expect(current_path).to eq(feeds_path)
    expect(page).to have_content('the 10 most recent dreams from all users')

    within('footer') { click_on 'Terms' }
    expect(current_path).to eq(terms_path)
    expect(page).to have_content('By registering for this site')
  end
end
