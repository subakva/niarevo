module CommonFeatureHelpers
  def ensure_on(path)
    visit(path) unless current_path == path
  end

  def display_alert(message)
    have_selector(".alert", :text => message)
  end
end

RSpec.configure do |config|
  config.include CommonFeatureHelpers, type: :feature
end
