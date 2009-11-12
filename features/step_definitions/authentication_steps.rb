Given /^I have created an account for "([^\"]*)"$/ do |login|
  unless User.exists?(:login => login)
    Factory.create(:user, :login => login)
  end
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