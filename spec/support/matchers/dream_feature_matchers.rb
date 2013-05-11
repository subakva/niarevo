RSpec::Matchers.define :display_dream_tags do |expected|
  match do |page|
    expected.each do |tag|
      expect(dream_tags_element).to have_content(tag)
    end
  end

  def dream_tags_element
    page.find('.content-tags')
  end

  def actual_tags
    dream_tags_element.text.split
  end

  failure_message_for_should do |page|
    "expected page to contain dream tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end

  failure_message_for_should_not do |page|
    "expected page not to contain dream tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end
end

RSpec::Matchers.define :display_dreamer_tags do |expected|
  match do |page|
    expected.each do |tag|
      expect(dreamer_tags_element).to have_content(tag)
    end
  end

  def dreamer_tags_element
    page.find('.context-tags')
  end

  def actual_tags
    dreamer_tags_element.text.split
  end

  failure_message_for_should do |page|
    "expected page to contain dreamer tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end

  failure_message_for_should_not do |page|
    "expected page not to contain dreamer tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end
end

module DreamMatcherMethods
  def include_recaptcha
    have_selector('[name=recaptcha_challenge_field]')
  end

  def display_dreamer_name(name)
    have_selector(".dream-dreamer", :text => name)
  end

  def display_dream_text(text)
    have_selector(".dream-text", :text => text)
  end
end

RSpec.configure do |config|
  config.include DreamMatcherMethods, type: :feature
end
