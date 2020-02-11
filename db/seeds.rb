# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating mock-users"

users = User.all.where(nickname: "") + User.all.where(nickname: nil)

users.each do |u|
  nickname = Faker::FunnyName.name
  location = Faker::Address.street_address + ', ' + Faker::Address.city
  age = Faker::Number.within(range: 18..70)
  gender = Faker::Gender.binary_type
  
  u.update_attributes(nickname: nickname,location: location, age: age, gender: gender)
end