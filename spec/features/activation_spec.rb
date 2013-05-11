require 'spec_helper'

feature "Activation" do

  background do
    clear_emails
    @user = FactoryGirl.create(:user, :inactive)
  end

  after do
    @user.destroy
  end

  context 'with an unactivated user' do
    before { request_new_activation(@user) }

    scenario "displaying a message about the activation email" do
      expect(page).to display_alert(%{
        An activation key was sent by email.
        Follow the link in the email to activate your account.
      }.squish)
      expect(current_path).to eq(root_path)
    end

    scenario "sending an activation email" do
      expect(open_email(@user.email)).to_not be_nil
      expect(current_email).to have_content(activation_path(@user.perishable_token))
    end

    scenario "activating the account" do
      visit edit_activation_path(@user.perishable_token)

      expect(page).to have_content("Your account is now activated! Please sign in.")
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'with an activated user' do
    before do
      @user.activate!
      request_new_activation(@user)
    end

    scenario 'redirects to the password reset page' do
      expect(page).to display_alert(
        "Your account is already active. Maybe you need to reset your password?"
      )
      expect(current_url).to eq(new_password_reset_url(username: @user.username))
    end
  end

end
