require 'spec_helper'

feature 'Dream Lists' do

  scenario 'viewing all recent dreams' do
    recent1    = FactoryGirl.create(:dream,             created_at: 1.month.ago)
    recent2    = FactoryGirl.create(:dream, :untagged,  created_at: 2.months.ago)
    not_recent = FactoryGirl.create(:dream,             created_at: 3.months.ago)

    ensure_on dreams_path(show: 2)

    expect(dream_list).to include_dreams(recent1, recent2)
    expect(dream_list).to_not include_dreams(not_recent)
  end

  scenario 'viewing anonymous dreams' do
    anonymous1    = FactoryGirl.create(:dream, :anonymous)
    anonymous2    = FactoryGirl.create(:dream, :anonymous, :untagged)
    not_anonymous = FactoryGirl.create(:dream)

    ensure_on user_dreams_path('anonymous')

    expect(dream_list).to include_dreams(anonymous1, anonymous2)
    expect(dream_list).to_not include_dreams(not_anonymous)
  end

  scenario 'viewing dreams for a user' do
    user = FactoryGirl.create(:user)
    user_dream1 = FactoryGirl.create(:dream, user: user)
    user_dream2 = FactoryGirl.create(:dream, user: user)
    wrong_user  = FactoryGirl.create(:dream)

    ensure_on user_dreams_path(user.username)

    expect(dream_list).to include_dreams(user_dream1, user_dream2)
    expect(dream_list).to_not include_dreams(wrong_user)
  end

  scenario 'viewing dreams with a tag' do
    tagged1       = FactoryGirl.create(:dream, dream_tag_list: ['stump'])
    tagged2       = FactoryGirl.create(:dream, dreamer_tag_list: ['stump'])
    not_matching  = FactoryGirl.create(:dream)

    ensure_on tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing dreams with a dream tag' do
    tagged1       = FactoryGirl.create(:dream, dream_tag_list: ['stump'])
    tagged2       = FactoryGirl.create(:dream, dream_tag_list: ['stump'])
    not_matching  = FactoryGirl.create(:dream, dreamer_tag_list: ['stump'])

    ensure_on dream_tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing dreams with a dreamer tag' do
    tagged1       = FactoryGirl.create(:dream, dreamer_tag_list: ['stump'])
    tagged2       = FactoryGirl.create(:dream, dreamer_tag_list: ['stump'])
    not_matching  = FactoryGirl.create(:dream, dream_tag_list: ['stump'])

    ensure_on dreamer_tag_dreams_path('stump')

    expect(dream_list).to include_dreams(tagged1, tagged2)
    expect(dream_list).to_not include_dreams(not_matching)
  end

  scenario 'viewing untagged dreams' do
    untagged1 = FactoryGirl.create(:dream, :untagged)
    untagged2 = FactoryGirl.create(:dream, :untagged)
    tagged    = FactoryGirl.create(:dream)
    ensure_on untagged_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams without dream tags' do
    untagged1 = FactoryGirl.create(:dream, dream_tag_list: [])
    untagged2 = FactoryGirl.create(:dream, dream_tag_list: [])
    tagged    = FactoryGirl.create(:dream, dream_tag_list: ['stump'], dreamer_tag_list: [])
    ensure_on untagged_dream_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams without dreamer tags' do
    untagged1 = FactoryGirl.create(:dream, dreamer_tag_list: [])
    untagged2 = FactoryGirl.create(:dream, dreamer_tag_list: [])
    tagged    = FactoryGirl.create(:dream, dreamer_tag_list: ['stump'], dream_tag_list: [])
    ensure_on untagged_dreamer_dreams_path

    expect(dream_list).to include_dreams(untagged1, untagged2)
    expect(dream_list).to_not include_dreams(tagged)
  end

  scenario 'viewing dreams by year' do
    this_year1    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    this_year2    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    previous_year = FactoryGirl.create(:dream, created_at: 1.year.ago)

    ensure_on dreams_by_year_path(year: this_year1.created_at.year)

    expect(dream_list).to include_dreams(this_year1, this_year2)
    expect(dream_list).to_not include_dreams(previous_year)
  end

  scenario 'viewing dreams by month' do
    this_month1    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    this_month2    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    previous_month = FactoryGirl.create(:dream, created_at: 1.month.ago)

    ensure_on dreams_by_month_path(
      year: this_month1.created_at.year,
      month: this_month1.created_at.month
    )

    expect(dream_list).to include_dreams(this_month1, this_month2)
    expect(dream_list).to_not include_dreams(previous_month)
  end

  scenario 'viewing dreams by day' do
    this_day1    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    this_day2    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    previous_day = FactoryGirl.create(:dream, created_at: 1.day.ago)

    ensure_on dreams_by_month_path(
      year: this_day1.created_at.year,
      month: this_day1.created_at.month,
      day: this_day1.created_at.day
    )

    expect(dream_list).to include_dreams(this_day1, this_day2)
    expect(dream_list).to_not include_dreams(previous_day)
  end
end
