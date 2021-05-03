# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "dreamer-#{n}" }
    email { "#{username}@example.com" }
    password { 'password' }
    password_confirmation { password }
    active { true }

    trait :inactive do
      active { false }
    end
  end
end
