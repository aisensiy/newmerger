# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

if User.count == 0
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

if Bargain.count == 0
  bargain_rows = CSV.read('db/bargains.csv', headers: true)
  bargain_rows.each { |row| Bargain.create!(row.to_hash) }
end

if Buyer.count == 0
  buyer_rows = CSV.read('db/buyers.csv', headers: true)
  buyer_rows.each { |row| Buyer.create!(row.to_hash) }
end

if Target.count == 0
  target_rows = CSV.read('db/targets.csv', headers: true)
  target_rows.each { |row| Target.create(row.to_hash) }
end

if Industry.count == 0
  industry_rows = CSV.read('db/industries.csv', headers: true)
  industry_rows.each { |row| Industry.create(row.to_hash) }
end
