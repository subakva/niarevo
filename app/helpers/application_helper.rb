module ApplicationHelper
  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html
  end

  def render_form_errors(errors)
    rendered = ''
    unless errors.blank?
      rendered << '<ul>'
      for error in errors.full_messages
        rendered << "<li class='error-line'>#{error}</li>"
      end
      rendered << '</ul>'
    end
    rendered
  end
end
