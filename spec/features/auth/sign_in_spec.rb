# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Sign In" do
  let(:password) { 'password' }
  let(:user) { FactoryBot.create(:user, password: password) }

  before { User.destroy_all }

  after { user.destroy }

  describe 'an activated user' do
    before { user.activate! }

    it 'redirecting after sign-in' do
      visit edit_account_path(user)
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
      sign_in(user.username, password)
      expect(page).to have_current_path(edit_account_path(user), ignore_query: true)
    end

    it 'already logged in' do
      sign_in(user.username, password)
      visit new_user_session_path
      expect(page).to have_current_path(account_path, ignore_query: true)
    end

    it 'entering valid credentials' do
      sign_in(user.username, password)
      expect(page).to have_current_path(account_path, ignore_query: true)
    end

    it 'entering an unknown username' do
      sign_in('nobody', password)

      expect(page).to display_alert('Please enter a correct username and password')
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end

    it 'entering an invalid password' do
      sign_in(user.username, 'this is not valid')

      expect(page).to display_alert('Please enter a correct username and password')
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end
  end

  describe 'an inactive user' do
    before { user.deactivate! }

    it 'displaying a message about the inactive account' do
      sign_in(user.username, password)

      expect(page).to display_alert('Your account has not been activated yet.')
      expect(page).to have_current_path(new_user_session_path, ignore_query: true)
    end
  end
end
