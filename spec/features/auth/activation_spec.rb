# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Activation' do
  include ActiveJob::TestHelper

  let(:user) { FactoryGirl.create(:user, :inactive) }

  background do
    clear_emails
  end

  after do
    user.destroy
  end

  scenario 'with an unknown username' do
    visit new_activation_path
    expect(page).to have_title('DreamTagger - Request Activation Key')
    within 'form' do
      fill_in 'Username or email', with: 'tarnation'
      click_button 'Send Activation Email'
    end
    expect(page).to have_title('DreamTagger - Request Activation Key')
    expect(page).to display_alert('Sorry, we couldn\'t find that account.')
  end

  scenario 'accessing via index' do
    visit activations_path
    expect(page).to have_title('DreamTagger - Request Activation Key')
  end

  scenario 'with an unknown token' do
    visit edit_activation_path('junk-of-a-token')
    expect(page).to have_title('DreamTagger - Sign In')
    expect(page).to display_alert('Sorry, we couldn\'t find that account.')
  end

  context 'with an unactivated user' do
    background do
      perform_enqueued_jobs do
        request_new_activation(user)
      end
    end

    scenario 'requesting an activation' do
      expect(current_path).to eq(root_path)

      expect(page).to display_alert(%(
        An activation key was sent by email.
        Follow the link in the email to activate your account.
      ).squish)

      expect(user).to have_email_with(
        activation_path(user.perishable_token)
      )
    end

    scenario 'activating the account' do
      visit edit_activation_path(user.perishable_token)

      expect(current_path).to eq(new_user_session_path)

      expect(page).to have_content('Your account is now activated! Please sign in.')
    end
  end

  context 'with an activated user' do
    background do
      user.activate!
      request_new_activation(user)
    end

    scenario 'redirecting to the password reset page' do
      expect(page).to display_alert(
        'Your account is already active. Maybe you need to reset your password?'
      )
      expect(current_url).to eq(new_password_reset_url(username: user.username))
    end
  end
end
