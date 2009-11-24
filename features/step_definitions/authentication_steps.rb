Given /the following users exist:/ do |user_table|
  user_table.hashes.each do |hash|
    user = User.find_by_username(hash['username'])
    user ||= Factory.create(:user, :username => hash['username'])
  end
end

Given /^I have activated an account for "([^\"]*)"$/ do |username|
  @current_user = User.find_by_username(username)
  @current_user ||= Factory.create(:user, :username => username, :active => true)
end

Given /^I have created an account for "([^\"]*)"$/ do |username|
  @current_user = User.find_by_username(username)
  @current_user ||= Factory.create(:user, :username => username, :active => false)
end

Given /^I am logged in as "([^\"]*)"$/ do |username|
  Given "I have activated an account for \"#{username}\""
  And 'I am on the home page'
  And 'I follow "Sign In"'
  And "I fill in \"Username\" with \"#{username}\""
  And 'I fill in "Password" with "password"'
  And 'I press "Sign In"'
  Then 'I should be on the account page'
end

Given /^I have registered an account$/ do
  Given 'I am on the new account page'
  And 'I fill in "Username" with "cucumber"'
  And 'I fill in "Email" with "cucumber@example.com"'
  And 'I fill in "Password" with "password"'
  And 'I fill in "Confirm Password" with "password"'
  And 'I press "Register"'
  @current_user = User.find_by_username('cucumber')
end
