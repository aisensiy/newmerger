class ElectricIndustryRefactory < ActiveRecord::Migration
  def up
    buyer_industry_id = Industry.find_by(name: '电力、热力、燃气及水生产和供应业').id
    target_industry_id = Industry.find_by(name: '电力、煤气及水的生产和供应业').id
    Target.where(industry_id: target_industry_id)
      .update_all(industry_id: buyer_industry_id)
  end

  def down
    buyer_industry_id = Industry.findby(name: '电力、热力、燃气及水生产和供应业').id
    target_industry_id = Industry.findby(name: '电力、煤气及水的生产和供应业').id
    Target.where(industry_id: buyer_industry_id)
      .update_all(industry_id: target_industry_id)
  end
end
