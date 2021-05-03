# frozen_string_literal: true

module FormHelper
  def dt_text_area(form, symbol, options = nil, &block)
    options = { class: 'form-control', rows: 10 }.merge(options || {})
    DreamTaggerControl.new(form, :text_area, symbol, options).render(self, &block)
  end

  def dt_text_field(form, symbol, options = nil, &block)
    options = { class: 'form-control' }.merge(options || {})
    DreamTaggerControl.new(form, :text_field, symbol, options).render(self, &block)
  end

  def dt_email_field(form, symbol, options = nil, &block)
    options = { class: 'form-control' }.merge(options || {})
    DreamTaggerControl.new(form, :email_field, symbol, options).render(self, &block)
  end

  def dt_password_field(form, symbol, options = nil, &block)
    options = { class: 'form-control' }.merge(options || {})
    DreamTaggerControl.new(form, :password_field, symbol, options).render(self, &block)
  end

  def dt_check_box(form, symbol, options = nil, &block)
    options = { class: 'form-control' }.merge(options || {})
    DreamTaggerControl.new(form, :check_box, symbol, options).render(self, &block)
  end

  def dt_submit(form, button_text, &block)
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'col-sm-offset-3 col-sm-9 action-controls') do
        controls_html = []
        controls_html << form.submit(button_text, class: 'btn btn-primary')
        controls_html << capture(&block) if block_given?
        safe_join(controls_html, '')
      end
    end
  end

  def dt_help_icon(href)
    return '' if href.blank?

    content_tag(:a, href: href, class: 'btn btn-default btn-help', data: { toggle: 'modal' }) do
      content_tag(:i, '', class: 'fa fa-question-circle')
    end
  end
end
