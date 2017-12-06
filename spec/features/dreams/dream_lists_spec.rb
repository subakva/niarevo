# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Dream Lists' do
  scenario 'viewing all recent dreams' do
    recent1    = FactoryBot.create(:dream,             created_at: 1.month.ago)
    recent2    = FactoryBot.create(:dream, :untagged,  created_at: 2.months.ago)
    not_recent = FactoryBot.create(:dream,             created_at: 3.months.ago)

    ensure_on dreams_path(show: 2)

    expect(dream_list).to include_dreams(recent1, recent2)
    expect(dream_list).to_not include_dreams(not_recent)
  end

  scenario 'viewing anonymous dreams' do
    anonymous1    = FactoryBot.create(:dream, :anonymous)
    anonymous2    = FactoryBot.create(:dream, :anonymous, :untagged)
    not_anonymous = FactoryBot.create(:dream)

    ensure_on user_dreams_path('anonymous')

    expect(dream_list).to include_dreams(anonymous1, anonymous2)
    expect(dream_list).to_not include_dreams(not_anonymous)
  end

  scenario 'viewing dreams for a user' do
    user = FactoryBot.create(:user)
    user_dream1 = FactoryBot.create(:dream, user: user)
    user_dream2 = FactoryBot.create(:dream, user: user)
    wrong_user  = FactoryBot.create(:dream)

    ensure_on user_dreams_path(user.username)

    expect(dream_list).to include_dreams(user_dream1, user_dream2)
    expect(dream_list).to_not include_dreams(wrong_user)
  end

  scenario 'viewing dreams with a tag' do
    tagged1       = FactoryBot.create(:dream, dream_tags: ['stump'])
    tagged2       = FactoryBot.create(:dream, dreamer_tags: ['stump'])
    not_matching  = FactoryBot.create(:dream)

    ensure_on tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing dreams with a dream tag' do
    tagged1       = FactoryBot.create(:dream, dream_tags: ['stump'])
    tagged2       = FactoryBot.create(:dream, dream_tags: ['stump'])
    not_matching  = FactoryBot.create(:dream, dreamer_tags: ['stump'])

    ensure_on dream_tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing dreams with a dreamer tag' do
    tagged1       = FactoryBot.create(:dream, dreamer_tags: ['stump'])
    tagged2       = FactoryBot.create(:dream, dreamer_tags: ['stump'])
    not_matching  = FactoryBot.create(:dream, dreamer_tags: [], dream_tags: ['stump'])

    ensure_on dreamer_tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing untagged dreams' do
    untagged1 = FactoryBot.create(:dream, :untagged)
    untagged2 = FactoryBot.create(:dream, :untagged)
    tagged    = FactoryBot.create(:dream)
    ensure_on untagged_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams without dream tags' do
    untagged1 = FactoryBot.create(:dream, dream_tags: [])
    untagged2 = FactoryBot.create(:dream, dream_tags: [])
    tagged    = FactoryBot.create(:dream, dream_tags: ['stump'], dreamer_tags: [])
    ensure_on untagged_dream_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams without dreamer tags' do
    untagged1 = FactoryBot.create(:dream, dreamer_tags: [])
    untagged2 = FactoryBot.create(:dream, dreamer_tags: [])
    tagged    = FactoryBot.create(:dream, dreamer_tags: ['stump'], dream_tags: [])
    ensure_on untagged_dreamer_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams by year' do
    this_year1    = FactoryBot.create(:dream, created_at: Time.zone.now)
    this_year2    = FactoryBot.create(:dream, created_at: Time.zone.now)
    previous_year = FactoryBot.create(:dream, created_at: 1.year.ago)

    ensure_on dreams_by_year_path(year: this_year1.created_at.year)

    expect(dream_list).to include_dreams(this_year1, this_year2)
    expect(dream_list).to_not include_dreams(previous_year)
  end

  scenario 'viewing dreams by month' do
    this_month1    = FactoryBot.create(:dream, created_at: Time.zone.now)
    this_month2    = FactoryBot.create(:dream, created_at: Time.zone.now)
    previous_month = FactoryBot.create(:dream, created_at: 1.month.ago)

    ensure_on dreams_by_month_path(
      year: this_month1.created_at.year,
      month: this_month1.created_at.month
    )

    expect(dream_list).to include_dreams(this_month1, this_month2)
    expect(dream_list).to_not include_dreams(previous_month)
  end

  scenario 'viewing dreams by day' do
    this_day1    = FactoryBot.create(:dream, created_at: Time.zone.now)
    this_day2    = FactoryBot.create(:dream, created_at: Time.zone.now)
    previous_day = FactoryBot.create(:dream, created_at: 1.day.ago)

    ensure_on dreams_by_month_path(
      year: this_day1.created_at.year,
      month: this_day1.created_at.month,
      day: this_day1.created_at.day
    )

    expect(dream_list).to include_dreams(this_day1, this_day2)
    expect(dream_list).to_not include_dreams(previous_day)
  end
end
