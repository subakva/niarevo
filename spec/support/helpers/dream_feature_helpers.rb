module DreamFeatureHelpers
  def new_dream_form
    find('#new_dream')
  end

  def dream_list
    find('.dream-list')
  end

  def dream_item(dream)
    find(%{[data-dream-id="#{dream.id}"]})
  end
end

RSpec.configure do |config|
  config.include DreamFeatureHelpers, type: :feature
end
