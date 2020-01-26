# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :user
    likeable { FactoryBot.build(%i[post comment].sample) }

    trait :for_post do
      likeable { FactoryBot.build(:post) }
    end

    trait :for_comment do
      likeable { FactoryBot.build(:comment) }
    end
  end
end
