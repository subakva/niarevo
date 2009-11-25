Given /the following dreams exist:/ do |dream_table|
  dream_table.hashes.each do |hash|
    user = hash.has_key?('username') ? User.find_by_username(hash['username']) : nil
    created_at = hash.has_key?('created_at') ? DateTime.parse(hash['created_at']) : Time.now
    content_tag_list = hash.has_key?('content_tags') ? hash['content_tags'] : ''
    context_tag_list = hash.has_key?('context_tags') ? hash['context_tags'] : ''
    Factory.create(:dream,
      :description => hash['description'],
      :user => user,
      :content_tag_list => content_tag_list,
      :context_tag_list => context_tag_list,
      :created_at => created_at
    )
  end
end

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

Given /^I enter the wrong captcha information$/ do
  RecaptchaHelpers.report_failure
end