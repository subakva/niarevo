Given /the following users exist:/ do |user_table|
  user_table.hashes.each do |hash|
    user = User.find_by_username(hash['username'])
    user ||= Factory.create(:user, :username => hash['username'])
  end
end

Given /^I have created an account for "([^\"]*)"$/ do |username|
  @current_user = User.find_by_username(username)
  @current_user ||= Factory.create(:user, :username => username)
end

Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given "I have created an account for \"#{username}\""
  And 'I am on the home page'
  And 'I follow "Sign In"'
  And "I fill in \"Username\" with \"#{username}\""
  And 'I fill in "Password" with "password"'
  And 'I press "Sign In"'
  Then 'I should be on the account page'
end