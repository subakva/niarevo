module ApplicationHelper
  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html
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
