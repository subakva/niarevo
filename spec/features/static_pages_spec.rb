# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static Pages' do
  it 'static pages are accessible' do
    visit root_path

    within('footer') { click_on 'About' }
    expect(page).to have_current_path(about_path, ignore_query: true)
    expect(page).to have_content('What is this?')

    within('footer') { click_on 'Feeds' }
    expect(page).to have_current_path(feeds_path, ignore_query: true)
    expect(page).to have_content('the 10 most recent dreams from all users')

    within('footer') { click_on 'Terms' }
    expect(page).to have_current_path(terms_path, ignore_query: true)
    expect(page).to have_content('By registering for this site')
  end
end
