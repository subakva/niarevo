RSpec::Matchers.define :have_email_with do |expected|
  match do |user|
    expect(open_email(user.email)).to_not be_nil
    expect(current_email).to have_content(expected)
  end

  failure_message_for_should do |actual|
    "expected that #{user.email} would have an email with content: #{expected}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{user.email} would not have an email with content: #{expected}"
  end
end
