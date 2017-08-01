# frozen_string_literal: true

RSpec::Matchers.define :display_dream_tags do |expected|
  match do |_|
    expected.each do |tag|
      expect(dream_tags_element).to have_content(tag)
    end
  end

  def dream_tags_element
    page.find('.dream-tags')
  end

  def actual_tags
    dream_tags_element.text.split
  end

  failure_message do |_|
    "expected page to contain dream tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end

  failure_message_when_negated do |_|
    "expected page not to contain dream tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end
end

RSpec::Matchers.define :display_dreamer_tags do |expected|
  match do |_|
    expected.each do |tag|
      expect(dreamer_tags_element).to have_content(tag)
    end
  end

  def dreamer_tags_element
    page.find('.dreamer-tags')
  end

  def actual_tags
    dreamer_tags_element.text.split
  end

  failure_message do |_|
    "expected page to contain dreamer tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end

  failure_message_when_negated do |_|
    "expected page not to contain dreamer tags: #{expected.inspect} but had: #{actual_tags.inspect}"
  end
end

RSpec::Matchers.define :include_dreams do |_expected|
  match do |_|
    expected_dream_ids.all? do |dream_id|
      dream_list.all(%([data-dream-id="#{dream_id}"])).first
    end
  end

  def expected_dream_ids
    [*expected].flatten.map(&:id)
  end

  failure_message do |_|
    "expected dream list to include dreams: #{expected_dream_ids.inspect} but did not."
  end

  failure_message_when_negated do |_|
    "expected dream list not to include dreams: #{expected_dream_ids.inspect} but did."
  end
end

module DreamMatcherMethods
  def include_recaptcha
    have_selector('.g-recaptcha')
  end

  def include_dream(dream)
    have_selector(%([data-dream-id="#{dream.id}"]))
  end

  def display_dreamer_name(name)
    have_selector(".dream-dreamer", text: name)
  end

  def display_dream_text(text)
    have_selector(".dream-text", text: text)
  end

  def display_private_dream
    have_selector('.dream-private i.fa.fa-lock')
  end

  def have_tag_link(tag)
    have_link(tag, href: tag_dreams_path(tag))
  end
end

RSpec.configure do |config|
  config.include DreamMatcherMethods, type: :feature
end
