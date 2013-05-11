RSpec::Matchers.define :display_alert do |expected|
  match do |page|
    expect(page.find('.alert')).to have_content(expected)
  end
end
