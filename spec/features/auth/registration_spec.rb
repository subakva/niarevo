require 'spec_helper'

feature "Registration" do
  include ActiveJob::TestHelper

  let(:username) { 'buzzard' }
  let(:user) { User.where(username: username).first! }

  background do
    clear_emails
    perform_enqueued_jobs do
      register_account(username)
    end
  end

  after do
    user.destroy
  end

  scenario "successful registration" do
    expect(page).to display_alert(
      "Thanks! A message has been sent to your email address with a link to activate your account."
    )
    expect(user).to_not be_nil
    expect(user).to have_email_with(
      edit_activation_path(user.perishable_token)
    )
  end
end
