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
  industry_rows = CSV.read('db/secondary_industries.csv', headers: true)
  industry_rows.each { |row| Industry.create(row.to_hash.merge({is_secondary: true})) }
end

Bargain.where(target_id: nil).find_each do |bargain|
  target_name = bargain.target_name
  target = Target.find_by(company_name: target_name)
  if target
    bargain.target_id = target.id
    bargain.save
  end
end

Bargain.where(buyer_id: nil).find_each do |bargain|
  stock_code = bargain.buyer_stock_code
  buyer = Buyer.find_by(stock_code: stock_code)
  if buyer
    bargain.buyer_id = buyer.id
    bargain.save
  end
end

Buyer.where(industry_id: nil).find_each do |buyer|
  industry, secondary_industry = buyer.industry.split('-')
  industry_obj = Industry.find_by(name: industry)
  if secondary_industry
    secondary_industry_obj = Industry.find_by(name: secondary_industry, is_secondary: true)
  end
  if industry_obj
    buyer.industry_id = industry_obj.id
    if secondary_industry
      buyer.secondary_industry_id = secondary_industry_obj.id
    end
    buyer.save
  end
end

Target.where(industry_id: nil).find_each do |target|
  industry, secondary_industry = target.target_industry.split('-')
  industry_obj = Industry.find_by(name: industry)
  if secondary_industry
    secondary_industry_obj = Industry.find_by(name: secondary_industry, is_secondary: true)
  end
  if industry_obj
    target.industry_id = industry_obj.id
    if secondary_industry
      target.secondary_industry_id = secondary_industry_obj.id
    end
    target.save
  end
end

def target_industry_to_buyer_industry(from, to, is_secondary=false)
  from_id = Industry.find_by(name: from, is_secondary: is_secondary).id
  to_id = Industry.find_by(name: to, is_secondary: is_secondary).id

  if is_secondary
    Target.where(secondary_industry_id: from_id).update_all(secondary_industry_id: to_id)
  else
    Target.where(industry_id: from_id).update_all(industry_id: to_id)
  end
end

target_industry_to_buyer_industry('采掘业', '采矿业')
target_industry_to_buyer_industry('电力、煤气及水的生产和供应业', '电力、热力、燃气及水生产和供应业')
target_industry_to_buyer_industry('信息技术业', '信息传输、软件和信息技术服务业')
target_industry_to_buyer_industry('交通运输、仓储业', '交通运输、仓储和邮政业')
target_industry_to_buyer_industry('金融、保险业', '金融业')
target_industry_to_buyer_industry('金融保险业', '金融业')
target_industry_to_buyer_industry('综合类', '综合')
target_industry_to_buyer_industry('传播与文化产业', '文化、体育和娱乐业')
target_industry_to_buyer_industry('批发和零售贸易', '批发和零售业')
