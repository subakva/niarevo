module DreamFeatureHelpers
  def new_dream_form
    find('#new_dream')
  end
end

RSpec.configure do |config|
  config.include DreamFeatureHelpers, type: :feature
end
