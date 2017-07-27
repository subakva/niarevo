module ApplicationHelper

  def page_title
    ['DreamTagger', header_text].uniq.join(' - ')
  end

  def header_text
    @header_text ||= begin
      if content_for?(:header_text)
        content_for(:header_text)
      end
    end
  end

  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html.html_safe
  end

  def strip_markdown(markdown)
    rendered = render_markdown(markdown)
    strip_tags(rendered)
  end

  def alert_class(alert_type)
    alert_type = {
      alert: 'danger',
      notice: 'info',
      recaptcha_error: 'warning'
    }.fetch(alert_type, alert_type.to_s)
    "alert-#{alert_type}"
  end
end
