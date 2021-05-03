# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Password Reset' do
  include ActiveJob::TestHelper

  let(:user) { FactoryBot.create(:user) }

  before do
    clear_emails
  end

  after do
    user.destroy
  end

  it 'with an unknown username' do
    visit new_password_reset_path
    expect(page).to have_title('DreamTagger - Forgot Password')
    within 'form' do
      fill_in 'Username or email', with: 'tarnation'
      click_button 'Reset Password'
    end
    expect(page).to have_title('DreamTagger - Forgot Password')
    expect(page).to display_alert('Sorry, we couldn\'t find that account.')
  end

  it 'accessing via index' do
    visit password_resets_path
    expect(page).to have_title('DreamTagger - Forgot Password')
  end

  it 'with an unknown token' do
    visit edit_password_reset_path('junk-of-a-token')
    expect(page).to have_title('DreamTagger - Sign In')
    expect(page).to display_alert('Sorry, we couldn\'t find that account.')
  end

  context 'with an activated user' do
    before do
      perform_enqueued_jobs do
        request_new_password(user)
      end
    end

    it 'requesting a password reset' do
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)

      expect(page).to display_alert(
        'Instructions to reset your password have been emailed to you.'
      )

      expect(user).to have_email_with(
        password_reset_path(user.perishable_token)
      )
    end

    it "setting a new password" do
      visit edit_password_reset_path(user.perishable_token)

      fill_in 'Password', with: 'drowssap'
      fill_in 'Confirm password', with: ''
      click_button 'Save new password'

      expect(page).to display_form_error(
        "Password confirmation doesn't match Password"
      )

      fill_in 'Password', with: 'drowssap'
      fill_in 'Confirm password', with: 'drowssap'
      click_button 'Save new password'

      expect(page).to have_current_path(account_path, ignore_query: true)

      expect(page).to display_alert('Your password has been updated.')
    end
  end

  context 'with an unactivated user' do
    before do
      user.deactivate!
      request_new_password(user)
    end

    it 'redirecting to the activation page' do
      expect(open_email(user.email)).to be_nil

      expect(page).to display_alert(
        'Your account is not yet active. Do you need us to resend your activation key?'
      )
      expect(current_url).to eq(new_activation_url(username: user.username))
    end
  end
end
