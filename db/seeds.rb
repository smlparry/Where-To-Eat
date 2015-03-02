require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(0..50).each do |i|
    Category.create({restaurant_id: rand(0..152), category: Faker::Hacker.adjective + '_' + i.to_s })
end

(0..400).each do |i|
    Item.create({restaurant_id: rand(0..152), category_id: rand(0..50), item: Faker::App.name + '_' + i.to_s, price: rand(100..3000)})
end
