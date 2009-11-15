# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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
