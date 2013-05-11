module UserSessionsFeatureHelper

  def sign_in_as(user)
    sign_in(user.username, 'password')
  end

  def sign_in(username, password)
    visit new_user_session_path

    within('#new_user_session') do
      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_on 'Sign In'
    end
  end

  def sign_out
    click 'Sign Out'
  end

  def request_new_password(user)
    visit new_user_session_path
    click_link 'Forgot your password?'

    fill_in 'Username or email', with: user.username
    click_button 'Reset Password'

    user.reload # reload to get the latest auth tokens
  end

end

RSpec.configure do |config|
  config.include UserSessionsFeatureHelper, type: :feature
end
