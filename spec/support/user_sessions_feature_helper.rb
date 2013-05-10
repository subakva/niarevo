module UserSessionsFeatureHelper

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

end

RSpec.configure do |config|
  config.include UserSessionsFeatureHelper, type: :feature
end
