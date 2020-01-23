require 'faker'

  FactoryBot.define do
    factory :user, aliases: %i[friendable friend] do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      nickname { Faker::Name.first_name }
      location { Faker::Address.city }
      gender { Faker::Gender.binary_type }
      age { rand(1..90) }
    end
  end