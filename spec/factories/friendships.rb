FactoryBot.define do
  factory :friendship do
    user { nil }
    friend { nil }
    confirmed { false }
  end
end
