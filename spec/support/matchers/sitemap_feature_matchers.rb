RSpec::Matchers.define :have_mapped_url do |loc, options|
  match do |doc|
    url_found?(doc, loc) && options_match?(doc, loc, options)
  end

  def url_element(doc, loc)
    @url_element = doc.xpath(%{//xmlns:url[xmlns:loc="#{loc}"]})
  end

  def url_found?(doc, loc)
    url_element(doc, loc).present?
  end

  def options_match?(doc, loc, options)
    options.to_a.all? do |(name, expected)|
      actual_text = url_element(doc, loc).xpath("xmlns:#{name}").try(:text)
      case name
      when :lastmod
        actual_text[0,19] == expected.iso8601[0,19]
      else
        actual_text == expected.to_s
      end
    end
  end

  failure_message do |doc|
    if url_found?(doc, loc)
      "expected url to have options: #{options.inspect}"
    else
      "expected sitemap to include url: #{loc}"
    end
  end

  failure_message_when_negated do |actual|
    "expected sitemap to not include url: #{loc.inspect}"
  end
end
