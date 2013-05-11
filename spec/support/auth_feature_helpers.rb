module AuthFeatureHelpers
  def registration_form
    find('#new_user')
  end

  def login_form
    find('#new_user_session')
  end

  def sign_in_as(user)
    sign_in(user.username, 'password')
  end

  def sign_in(username, password)
    ensure_on new_user_session_path

    within(login_form) do
      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_on 'Sign In'
    end
  end

  def sign_out
    click 'Sign Out'
  end

  def request_new_password(user)
    ensure_on new_user_session_path
    click_link 'Forgot your password?'

    fill_in 'Username or email', with: user.username
    click_button 'Reset Password'

    user.reload # reload to get the latest auth tokens
  end

  def request_new_activation(user)
    ensure_on new_user_session_path
    click_link 'Need a new activation email?'

    fill_in 'Username or email', with: user.username
    click_button 'Send Activation Email'

    user.reload # reload to get the latest auth tokens
  end

  def register_account(username)
    ensure_on new_user_path
    within registration_form do
      fill_in "Username", with: username
      fill_in "Email",    with: "#{username}@example.com"
      fill_in "Password", with: "p@ssword"
      fill_in "Confirm password", with: "p@ssword"
      click_button "Create Account"
    end
  end

end

RSpec.configure do |config|
  config.include AuthFeatureHelpers, type: :feature
end
