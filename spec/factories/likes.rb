FactoryBot.define do
  factory :like do
    user { nil }
    likeable_id { 1 }
    likeable_type { "MyString" }
  end
end
