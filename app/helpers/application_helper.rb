# frozen_string_literal: true

module ApplicationHelper
  def page_title
    ['DreamTagger', header_text].uniq.join(' - ')
  end

  def header_text
    @header_text ||= begin # rubocop:disable Style/RedundantBegin
      content_for(:header_text) if content_for?(:header_text)
    end
  end

  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html.html_safe # rubocop:disable Rails/OutputSafety
  end

  def strip_markdown(markdown)
    rendered = render_markdown(markdown)
    strip_tags(rendered)
  end

  def alert_class(alert_type)
    alert_type = {
      alert: 'danger',
      notice: 'info',
    }.fetch(alert_type.to_sym, alert_type.to_s)
    "alert-#{alert_type}"
  end

  def paginated?(array)
    return false unless array.respond_to?(:next_page)

    array.next_page.present? || array.prev_page.present?
  end
end
