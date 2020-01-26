# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.paragraph }
    content { Faker::Lorem.paragraph }
    association :user

    trait :invalid do
      content { '' }
    end
  end
end
