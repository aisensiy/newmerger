# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

User.delete_all
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Bargain.delete_all
bargain_rows = CSV.read('db/bargains.csv', headers: true)
bargain_rows.each { |row| Bargain.create!(row.to_hash) }

Buyer.delete_all
buyer_rows = CSV.read('db/buyers.csv', headers: true)
buyer_rows.each { |row| Buyer.create!(row.to_hash) }

Target.delete_all
target_rows = CSV.read('db/targets.csv', headers: true)
target_rows.each { |row| Target.create(row.to_hash) }
