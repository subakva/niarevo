RSpec::Matchers.define :have_email_with do |expected|
  match do |user|
    expect(open_email(user.email)).to_not be_nil
    expect(current_email).to have_content(expected)
  end

  failure_message do |actual|
    "expected that #{user.email} would have an email with content: #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{user.email} would not have an email with content: #{expected}"
  end
end

module CommonMatcherMethods
  def display_form_error(text)
    have_selector(".error-label", :text => text)
  end

  def display_alert(message)
    have_selector(".alert", :text => message)
  end
end

RSpec.configure do |config|
  config.include CommonMatcherMethods, type: :feature
end
