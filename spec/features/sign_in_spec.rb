require 'spec_helper'

feature "Sign In" do
  let(:password) { 'password' }

  before(:all) do
    User.destroy_all
    @user = FactoryGirl.create(:user)
  end

  after(:all) do
    @user.destroy
  end

  describe 'an activated user' do
    before(:all) do
      @user.activate!
    end

    scenario 'authenticates with valid credentials' do
      sign_in(@user.username, password)

      expect(current_path).to eq(account_path)
    end

    scenario 'displays a generic error message with an unknown username' do
      sign_in('nobody', password)

      expect(page).to display_alert('Please enter a correct username and password')
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'displays a generic error message with an invalid password' do
      sign_in(@user.username, 'this is not valid')

      expect(page).to display_alert('Please enter a correct username and password')
      expect(current_path).to eq(new_user_session_path)
    end
  end

  describe 'an inactive user' do
    before(:all) do
      @user.deactivate!
    end

    scenario 'displays a message about the inactive account' do
      sign_in(@user.username, password)

      expect(page).to display_alert('Your account has not been activated yet.')
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
