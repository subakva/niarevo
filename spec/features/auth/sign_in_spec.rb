# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Sign In" do
  let(:password) { 'password' }
  let(:user) { FactoryGirl.create(:user, password: password) }

  before { User.destroy_all }
  after { user.destroy }

  describe 'an activated user' do
    before { user.activate! }

    scenario 'redirecting after sign-in' do
      visit edit_account_path(user)
      expect(current_path).to eq(new_user_session_path)
      sign_in(user.username, password)
      expect(current_path).to eq(edit_account_path(user))
    end

    scenario 'already logged in' do
      sign_in(user.username, password)
      visit new_user_session_path
      expect(current_path).to eq(account_path)
    end

    scenario 'entering valid credentials' do
      sign_in(user.username, password)
      expect(current_path).to eq(account_path)
    end

    scenario 'entering an unknown username' do
      sign_in('nobody', password)

      expect(page).to display_alert('Please enter a correct username and password')
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'entering an invalid password' do
      sign_in(user.username, 'this is not valid')

      expect(page).to display_alert('Please enter a correct username and password')
      expect(current_path).to eq(new_user_session_path)
    end
  end

  describe 'an inactive user' do
    before { user.deactivate! }

    scenario 'displaying a message about the inactive account' do
      sign_in(user.username, password)

      expect(page).to display_alert('Your account has not been activated yet.')
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
