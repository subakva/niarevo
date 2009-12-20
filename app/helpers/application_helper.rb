module ApplicationHelper
  include CloudStyleHelpers
  
  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html.html_safe!
  end

  def strip_markdown(markdown)
    rendered = render_markdown(markdown)
    strip_tags(rendered)
  end

  def render_form_errors(errors)
    rendered = ''
    unless errors.blank?
      rendered << '<ul class="form-errors">'
      errors.full_messages.each do |error|
        rendered << "<li class='error-line'>#{error}</li>"
      end
      rendered << '</ul>'
    end
    rendered
  end

end
