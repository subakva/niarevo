# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Private Dreams" do
  context 'an anonymous user' do
    let(:private_dream) { FactoryBot.create(:dream, :private) }

    scenario 'creating a dream' do
      ensure_on new_dream_path

      expect(page).to_not have_text('Private?')
    end

    scenario 'viewing the dream page' do
      ensure_on dream_path(private_dream)

      expect(current_path).to eq(root_path)
      expect(page).to display_alert("Sorry, that page doesn't exist!")
    end

    scenario 'viewing recent dreams' do
      ensure_on root_path

      expect(page).to_not display_dream_text(private_dream.description)
    end
  end

  context 'an authenticated user' do
    let(:user) { FactoryBot.create(:user) }
    let(:dream_text) { 'I attended an eel hat party on the Thames.' }
    let(:public_dream) { FactoryBot.create(:dream, user: user) }
    let(:private_dream) { FactoryBot.create(:dream, :private, description: 'privata', user: user) }

    background do
      sign_in_as user
    end

    scenario 'creating a private dream' do
      ensure_on new_dream_path

      within('#new_dream') do
        fill_in 'Describe Your Dream', with: dream_text
        check('Private?')
        click_on 'Save'
      end

      expect(current_path).to eq(dream_path(Dream.last))
      expect(page).to display_dream_text(dream_text)
      expect(page).to display_private_dream
    end

    scenario 'changing a public dream to a private dream' do
      ensure_on edit_dream_path(public_dream)

      within('.edit-dream') do
        check('Private?')
        click_on 'Save'
      end

      expect(current_path).to eq(dream_path(public_dream))
      expect(page).to display_private_dream
    end

    scenario 'viewing own private dream in the recent dreams list' do
      private_dream
      ensure_on root_path
      expect(page).to display_dream_text(private_dream.description)
      expect(page).to display_private_dream
    end

    context "with another person's private dream" do
      let(:other_user) { FactoryBot.create(:user) }
      let!(:private_dream) do
        FactoryBot.create(:dream, :private, description: 'privates here!', user: other_user)
      end

      scenario 'viewing the dream page' do
        ensure_on dream_path(private_dream)

        expect(current_path).to eq(root_path)
        expect(page).to display_alert("Sorry, that page doesn't exist!")
      end

      scenario 'viewing recent dreams' do
        ensure_on root_path

        expect(page).to_not display_dream_text(private_dream.description)
      end
    end
  end
end
