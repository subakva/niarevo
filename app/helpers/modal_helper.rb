# frozen_string_literal: true

module ModalHelper
  # rubocop:disable Metrics/MethodLength
  def help_modal(id, title, &block)
    modal_options = {
      'id' => id,
      'class' => 'modal fade',
      'tabindex' => -1,
      'data-toggle' => 'modal',
      'role' => 'dialog'
    }
    tag.div(modal_options) do
      tag.div(class: 'modal-dialog', role: 'document') do
        tag.div(class: 'modal-content') do
          safe_join(
            [
              modal_header(title),
              modal_body(&block),
              modal_footer
            ],
            ''
          )
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def modal_header(title)
    tag.div(class: 'modal-header') do
      tag.h3(title, class: 'modal-title')
    end
  end

  def modal_body(&block)
    tag.div(class: 'modal-body') do
      capture(&block) if block_given?
    end
  end

  def modal_footer
    tag.div(class: 'modal-footer') do
      tag.a('Close', href: '#', class: 'btn btn-default', 'data-dismiss' => 'modal')
    end
  end
end
