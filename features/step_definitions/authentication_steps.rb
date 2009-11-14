Given /^I have created an account for "([^\"]*)"$/ do |login|
  @current_user = User.find_by_login(login)
  @current_user ||= Factory.create(:user, :login => login)
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  Given "I have created an account for \"#{login}\""
  And 'I am on the home page'
  And 'I follow "Log In"'
  And "I fill in \"Login\" with \"#{login}\""
  And 'I fill in "Password" with "password"'
  And 'I press "Login"'
  Then 'I should be on the account page'
end