Given /^I have created a dream "([^\"]*)"$/ do |description|
  @current_dream = Factory.create(:dream, :description => description, :user => @current_user)
end

Given /^([0-9]*) numbered dreams have been recorded$/ do |count|
  1.upto(count.to_i) do |i|
    Factory.create(:dream, :description => "Dream #{i}")
  end
end

Then /^I should see dreams ([0-9]*) through ([0-9]*)$/ do |first, last|
  first.upto(last) do |i|
    Then "I should see \"Dream #{i}\""
  end
end

Then /^I should see dream ([0-9]*)$/ do |number|
  Then "I should see \"Dream #{number}\""
end

Then /^I should not see dream ([0-9]*)$/ do |number|
  Then "I should not see \"Dream #{number}\""
end
