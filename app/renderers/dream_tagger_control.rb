# frozen_string_literal: true

class DreamTaggerControl
  attr_reader :form, :input_method, :symbol, :options

  def initialize(form, input_method, symbol, options = nil)
    @form = form
    @input_method = input_method
    @symbol = symbol
    @options = {
      label: symbol.to_s.humanize
    }.merge(options || {})
  end

  def render(view, &block)
    view.tag.div(class: group_classes) do
      view.safe_join(
        [
          render_label(view),
          render_controls_element(view, &block)
        ],
        ''
      )
    end
  end

  def render_controls_element(view, &block)
    controls_parts = []
    controls_parts << view.tag.div(class: 'col-sm-4') do
      render_input_element
    end
    controls_parts << view.tag.div(class: 'col-sm-3') do
      view.capture(&block) if block_given?
    end
    view.safe_join(controls_parts, '')
  end

  def render_field_errors(view)
    error_content = []
    errors[symbol]&.each do |error|
      message = errors.full_message(symbol, error)
      error_content << view.tag.span(message, class: 'error-label')
    end
    view.safe_join(error_content, '')
  end

  def render_label(view)
    view.tag.div(class: 'col-sm-3') do
      view.safe_join(
        [
          form.label(symbol, options[:label], class: 'control-label'),
          render_field_errors(view)
        ],
        ''
      )
    end
  end

  # rubocop:disable Metrics/AbcSize
  def render_input_element
    input_method_params = [input_method, symbol]
    input_options = options.slice(:class)
    input_options[:value] = options[:value] if options.key?(:value)
    input_options[:rows] = options[:rows] if options.key?(:rows)
    input_method_params << input_options
    form.send(*input_method_params)
  end
  # rubocop:enable Metrics/AbcSize

  def errors
    @errors ||= form.object.errors
  end

  def group_classes
    errors[symbol].present? ? 'form-group has-error' : 'form-group'
  end
end
