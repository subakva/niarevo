# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Registration" do
  include ActiveJob::TestHelper

  let(:username) { 'buzzard' }
  let(:user) { User.where(username: username).first! }

  before do
    clear_emails
    perform_enqueued_jobs do
      register_account(username)
    end
  end

  after do
    user.destroy
  end

  it 'failed registration' do
    ensure_on new_user_path
    within registration_form do
      fill_in "Username", with: username
      fill_in "Email",    with: ""
      fill_in "Password", with: "password"
      fill_in "Confirm password", with: ""
      click_button "Create Account"
    end
    expect(page).to display_form_error("Email should look like an email address.")
    expect(page).to display_form_error("Password confirmation doesn't match Password")
  end

  it "successful registration" do
    expect(page).to display_alert(
      "Thanks! A message has been sent to your email address with a link to activate your account."
    )
    expect(user).not_to be_nil
    expect(user).to have_email_with(
      edit_activation_path(user.perishable_token)
    )
  end
end
