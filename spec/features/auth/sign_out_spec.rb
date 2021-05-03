# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Sign Out" do
  let(:user) { FactoryBot.create(:user) }

  it 'signing out to the home page' do
    sign_in_as(user)
    sign_out

    expect(page).to display_alert("You have been logged out.")
    expect(page).to have_current_path(root_path, ignore_query: true)
  end
end
