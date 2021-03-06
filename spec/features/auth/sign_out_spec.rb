# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Sign Out" do
  let(:user) { FactoryBot.create(:user) }

  scenario 'signing out to the home page' do
    sign_in_as(user)
    sign_out

    expect(page).to display_alert("You have been logged out.")
    expect(current_path).to eq(root_path)
  end
end
