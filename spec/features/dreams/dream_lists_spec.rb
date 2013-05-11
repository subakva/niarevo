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
    tagged1       = FactoryGirl.create(:dream, content_tag_list: ['stump'])
    tagged2       = FactoryGirl.create(:dream, context_tag_list: ['stump'])
    not_matching  = FactoryGirl.create(:dream)

    ensure_on tag_dreams_path('stump')

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

  scenario 'viewing dreams by year' do
    this_year1    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    this_year2    = FactoryGirl.create(:dream, created_at: Time.zone.now)
    previous_year = FactoryGirl.create(:dream, created_at: 1.year.ago)

    ensure_on dreams_by_year_path(year: this_year1.created_at.year)

    expect(dream_list).to include_dreams(this_year1, this_year2)
    expect(dream_list).to_not include_dreams(previous_year)
  end
end
