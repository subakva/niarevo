require 'spec_helper'

feature 'Password Reset' do
  let(:user) { FactoryGirl.create(:user) }

  background do
    clear_emails
  end

  after do
    user.destroy
  end

  context 'with an activated user' do
    background do
      request_new_password(user)
    end

    scenario 'requesting a password reset' do
      expect(current_path).to eq(new_user_session_path)

      expect(page).to display_alert(
        'Instructions to reset your password have been emailed to you.'
      )

      expect(user).to have_email_with(
        password_reset_path(user.perishable_token)
      )
    end

    scenario "setting a new password" do
      visit edit_password_reset_path(user.perishable_token)

      fill_in 'Password', with: 'drowssap'
      fill_in 'Confirm password', with: 'drowssap'
      click_button 'Save new password'

      expect(current_path).to eq(account_path)

      expect(page).to display_alert('Your password has been updated.')
    end
  end

  context 'with an unactivated user' do
    background do
      user.deactivate!
      request_new_password(user)
    end

    scenario 'redirecting to the activation page' do
      expect(open_email(user.email)).to be_nil

      expect(page).to display_alert(
        'Your account is not yet active. Do you need us to resend your activation key?'
      )
      expect(current_url).to eq(new_activation_url(username: user.username))
    end
  end

end
