require 'spec_helper'

feature "Password Reset" do

  background do
    clear_emails
    @user = FactoryGirl.create(:user)
    @user.activate!
  end

  after do
    @user.destroy
  end

  context 'with an activated user' do
    before { request_new_password(@user) }

    scenario "displays a message about the password reset email" do
      expect(page).to display_alert("Instructions to reset your password have been emailed to you.")
      expect(current_path).to eq(new_user_session_path)
    end

    scenario "sends a password reset email with url" do
      expect(open_email(@user.email)).to_not be_nil
      expect(current_email).to have_content(password_reset_path(@user.perishable_token))
    end

    scenario "resets the password" do
      visit edit_password_reset_path(@user.perishable_token)

      fill_in 'Password', with: 'drowssap'
      fill_in 'Confirm password', with: 'drowssap'
      click_button 'Save new password'

      expect(page).to have_content("Your password has been updated.")
      expect(current_path).to eq(account_path)
    end
  end

  context 'with an unactivated user' do
    before do
      @user.deactivate!
      request_new_password(@user)
    end

    scenario 'redirects to the activation page' do
      expect(open_email(@user.email)).to be_nil
      expect(page).to display_alert(
        "Your account is not yet active. Do you need us to resend your activation key?"
      )
      expect(current_url).to eq(new_activation_url(username: @user.username))
    end
  end

end
