module ModalHelper
  def help_modal(id, title, &block)
    modal_options = {
      'id' => id,
      'class' => 'modal hide fade',
      'tabindex' => -1,
      'data-toggle' => 'modal',
      'aria-hidden' => 'true'
    }
    content_tag(:div, modal_options) do
      [
        modal_header(title),
        modal_body(&block),
        modal_footer
      ].join('').html_safe
    end
  end

  def modal_header(title)
    content_tag(:div, class: 'modal-header') do
      content_tag(:h3, title)
    end
  end

  def modal_body(&block)
    content_tag(:div, class: 'modal-body') do
      capture(&block) if block_given?
    end
  end

  def modal_footer
    content_tag(:div, class: 'modal-footer') do
      content_tag(:a, 'Close', href: '#', class: 'btn', 'data-dismiss' => 'modal')
    end
  end
end
