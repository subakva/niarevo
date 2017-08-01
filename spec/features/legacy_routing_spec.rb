# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Legacy Routing' do
  scenario 'redirecting untagged context' do
    visit '/dreams/untagged_context'
    expect(current_path).to eq(untagged_dreamer_dreams_path)
  end

  scenario 'redirecting untagged content' do
    visit '/dreams/untagged_content'
    expect(current_path).to eq(untagged_dream_dreams_path)
  end

  scenario 'redirecting tagged context' do
    visit '/dreams/tagged/context/in-bruges'
    expect(current_path).to eq(dreamer_tag_dreams_path('in-bruges'))
  end

  scenario 'redirecting tagged content' do
    visit '/dreams/tagged/content/semolina'
    expect(current_path).to eq(dream_tag_dreams_path('semolina'))
  end
end
