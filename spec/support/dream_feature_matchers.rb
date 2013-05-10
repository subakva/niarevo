RSpec::Matchers.define :include_recaptcha do
  match do |page|
    page.assert_selector('[name=recaptcha_challenge_field]')
  end
end

RSpec::Matchers.define :display_dreamer_name do |expected|
  match do |page|
    expect(page.find('.dream-dreamer')).to have_content(expected)
  end
end

RSpec::Matchers.define :display_dream_text do |expected|
  match do |page|
    expect(page.find('.dream-text')).to have_content(expected)
  end
end

RSpec::Matchers.define :display_dream_tags do |expected|
  match do |page|
    dream_tags_element = page.find('.content-tags')
    dream_tags.each do |tag|
      expect(dream_tags_element).to have_content(tag)
    end
  end
end

RSpec::Matchers.define :display_dreamer_tags do |expected|
  match do |page|
    dreamer_tags_element = page.find('.context-tags')
    dreamer_tags.each do |tag|
      expect(dreamer_tags_element).to have_content(tag)
    end
  end
end
