# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Update Profile" do
  let(:user) { FactoryBot.create(:user) }

  scenario 'updating account details' do
    sign_in_as user
    visit edit_account_path(user)
    within 'form' do
      fill_in 'Email', with: ''
      click_on 'Update'
    end
    expect(page).to display_form_error("Email should look like an email address.")

    within 'form' do
      fill_in 'Email', with: 'spuds@example.com'
      click_on 'Update'
    end
    expect(page).to display_alert("Account updated!")

    click_on 'Edit Profile'
    expect(page).to have_field('Email', with: 'spuds@example.com')
  end
end
