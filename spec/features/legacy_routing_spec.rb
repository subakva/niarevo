# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Legacy Routing' do
  it 'redirecting untagged context' do
    visit '/dreams/untagged_context'
    expect(page).to have_current_path(untagged_dreamer_dreams_path, ignore_query: true)
  end

  it 'redirecting untagged content' do
    visit '/dreams/untagged_content'
    expect(page).to have_current_path(untagged_dream_dreams_path, ignore_query: true)
  end

  it 'redirecting tagged context' do
    visit '/dreams/tagged/context/in-bruges'
    expect(page).to have_current_path(dreamer_tag_dreams_path('in-bruges'), ignore_query: true)
  end

  it 'redirecting tagged content' do
    visit '/dreams/tagged/content/semolina'
    expect(page).to have_current_path(dream_tag_dreams_path('semolina'), ignore_query: true)
  end
end
