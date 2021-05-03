# frozen_string_literal: true

FactoryBot.define do
  factory :invite do
    user
    sequence(:recipient_name) { |n| "Muppet #{n}" }
    email { "#{recipient_name}@example.com".downcase.gsub(/\s/, '') }
    message { "You are invited by anyone to do anything." }
    sent_at { 1.day.ago }

    trait :unsent do
      sent_at { nil }
    end
  end
end
