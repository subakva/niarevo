require 'spec_helper'

feature "Anonymous Dreams" do
  let(:dream_attributes) { FactoryGirl.attributes_for(:dream, :anonymous) }
  let(:dream_text)    { dream_attributes[:description] }
  let(:dream_tags)    { dream_attributes[:dream_tag_list] }
  let(:dreamer_tags)  { dream_attributes[:dreamer_tag_list] }

  scenario 'adding a dream' do
    visit new_dream_path

    expect(page).to include_recaptcha

    within new_dream_form do
      fill_in 'Describe Your Dream',        with: dream_text
      fill_in 'Dream Tags',                 with: dream_tags.join(',')
      fill_in 'Dreamer Tags',               with: dreamer_tags.join(',')
      # We're not actually verifying the recaptcha, but this demonstrates usage.
      fill_in 'recaptcha_challenge_field',  with: 'fennel cornucopia'

      click_on 'Save'
    end

    expect(current_path).to eq(dream_path(Dream.last))

    expect(page).to display_dreamer_name('Anonymous')
    expect(page).to display_dream_text(dream_text)
    expect(page).to display_dream_tags(dream_tags)
    expect(page).to display_dreamer_tags(dreamer_tags)
  end

end