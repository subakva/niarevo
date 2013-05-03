require 'cloud_style_helpers'

module ApplicationHelper

  include CloudStyleHelpers

  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html.html_safe
  end

  def strip_markdown(markdown)
    rendered = render_markdown(markdown)
    strip_tags(rendered)
  end

  def dt_text_area(form, symbol, label_text, default_value = nil)
    dt_form_field(form, :text_area, symbol, label_text)
  end

  def dt_text_field(form, symbol, label_text, default_value = nil)
    dt_form_field(form, :text_field, symbol, label_text)
  end

  def dt_email_field(form, symbol, label_text, default_value = nil)
    dt_form_field(form, :email_field, symbol, label_text)
  end

  def dt_password_field(form, symbol, label_text, default_value = nil)
    dt_form_field(form, :password_field, symbol, label_text)
  end

  def dt_check_box(form, symbol, label_text, default_value = nil)
    dt_form_field(form, :check_box, symbol, label_text)
  end

  def dt_submit(form, button_text, &block)
    content_tag(:div, class: 'control-group') do
      content_tag(:div, class: 'controls') do
        controls_html = []
        controls_html << form.submit(button_text, class: 'btn btn-primary')
        controls_html << capture(&block) if block_given?
        controls_html.join('').html_safe
      end
    end
  end

  def dt_form_field(form, helper_method, symbol, label_text, default_value = nil)
    errors = form.object.errors
    group_classes = errors.present? ? 'control-group error' : 'control-group'
    content_tag(:div, class: group_classes) do
      label_html = form.label(symbol, label_text, class: 'control-label' )
      control_html = content_tag(:div, class: 'controls') do
        [
          form.send(helper_method, symbol),
          dt_field_errors(errors, symbol)
        ].join('').html_safe
      end
      [label_html, control_html].join('').html_safe
    end
  end

  def dt_field_errors(errors, symbol)
    error_content = []
    if errors[symbol]
      errors[symbol].each do |error|
        message = errors.full_message(symbol, error)
        error_content << content_tag(:span, message, class:'help-inline')
      end
    end
    error_content.join('').html_safe
  end

  def render_form_errors(errors)
    return if errors.blank?
    content_tag(:div, class: 'control-group error') do
      content_tag(:div, class: 'controls') do
        content_tag(:ul, class: 'unstyled') do
          errors_html = []
          errors.full_messages.each do |error|
            errors_html << content_tag(:li, class: 'error') do
              content_tag(:span, error, class:'help-inline')
            end
          end
          errors_html.join('').html_safe
        end

      end
    end
    # rendered = ''
    # unless errors.blank?
    #   rendered << '<ul class="form-errors">'
    #   errors.full_messages.each do |error|
    #     rendered << "<li class='error-line'>#{error}</li>"
    #   end
    #   rendered << '</ul>'
    # end
    # rendered.html_safe
  end
end
