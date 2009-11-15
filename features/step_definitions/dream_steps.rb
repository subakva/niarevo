Given /^I have created a dream "([^\"]*)"$/ do |description|
  @current_dream = Factory.create(:dream, :description => description, :user => @current_user)
end
