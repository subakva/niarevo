class DreamTaggerControl
  attr_reader :form, :input_method, :symbol, :options

  def initialize(form, input_method, symbol, options = nil)
    @form, @input_method, @symbol = form, input_method, symbol
    @options = {
      value: nil,
      label: symbol.to_s.humanize
    }.merge(options || {})
  end

  def render(view, &block)
    view.content_tag(:div, class: group_classes) do
      [
        render_label(view),
        render_controls_element(view, &block)
      ].join('').html_safe
    end
  end

  def render_controls_element(view, &block)
    view.content_tag(:div, class: 'controls') do
      controls_parts = []
      controls_parts << render_input_element
      controls_parts << view.capture(&block) if block_given?
      controls_parts.join('').html_safe
    end
  end

  def render_field_errors(view)
    error_content = []
    if errors[symbol]
      errors[symbol].each do |error|
        message = errors.full_message(symbol, error)
        error_content << view.content_tag(:span, message, class:'error-label')
      end
    end
    error_content.join('').html_safe
  end

  def render_label(view)
    [
      form.label(symbol, options[:label], class: 'control-label'),
      render_field_errors(view)
    ].join('').html_safe
  end

  def render_input_element
    input_method_params = [input_method, symbol]
    input_method_params << options.slice(:value) if options[:value].present?
    input_method_params << options[:options] if options[:options].present?
    form.send(*input_method_params)
  end

  def errors
    @errors ||= form.object.errors
  end

  def group_classes
    errors[symbol].present? ? 'control-group error' : 'control-group'
  end
end
