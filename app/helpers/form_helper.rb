module FormHelper
  def dt_text_area(form, symbol, options = nil, &block)
    dt_form_field(form, :text_area, symbol, options, &block)
  end

  def dt_text_field(form, symbol, options = nil, &block)
    dt_form_field(form, :text_field, symbol, options, &block)
  end

  def dt_email_field(form, symbol, options = nil, &block)
    dt_form_field(form, :email_field, symbol, options, &block)
  end

  def dt_password_field(form, symbol, options = nil, &block)
    dt_form_field(form, :password_field, symbol, options, &block)
  end

  def dt_check_box(form, symbol, options = nil, &block)
    dt_form_field(form, :check_box, symbol, options, &block)
  end

  def dt_form_field(form, input_method, symbol, options = nil, &block)
    options ||= {}
    options = {
      value: nil,
      label: symbol.to_s.humanize
    }.merge(options)
    errors = form.object.errors
    group_classes = errors.present? ? 'control-group error' : 'control-group'
    content_tag(:div, class: group_classes) do
      label_html = form.label(symbol, options[:label], class: 'control-label' )
      control_html = content_tag(:div, class: 'controls') do
        controls_parts = []
        controls_parts << invoke_input_method(form, input_method, symbol, options)
        controls_parts << dt_field_errors(errors, symbol)
        controls_parts << capture(&block) if block_given?
        controls_parts.join('').html_safe
      end
      [label_html, control_html].join('').html_safe
    end
  end

  def dt_submit(form, button_text, &block)
    content_tag(:div, class: 'control-group') do
      content_tag(:div, class: 'controls action-controls') do
        controls_html = []
        controls_html << form.submit(button_text, class: 'btn btn-primary')
        controls_html << capture(&block) if block_given?
        controls_html.join('').html_safe
      end
    end
  end

  def dt_help_icon(href)
    return '' if href.blank?
    content_tag(:a, href: href, class: 'btn btn-help', data: {toggle: 'modal'}) do
      content_tag(:i, '', class: 'icon-question-sign')
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

  def invoke_input_method(form, input_method, symbol, options)
    input_method_params = [input_method, symbol]
    input_method_params << options.slice(:value) if options[:value].present?
    form.send(*input_method_params)
  end
end
