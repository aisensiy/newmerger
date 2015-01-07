class ConnectIndustryToObject < ActiveRecord::Migration
  def up
    Buyer.where(industry_id: nil).find_each do |buyer|
      industry = buyer.industry.split('-')[0]
      industry_obj = Industry.find_by(name: industry)
      if industry_obj
        buyer.industry_id = industry_obj.id
        buyer.save
      end
    end

    Target.where(industry_id: nil).find_each do |target|
      industry = target.target_industry
      industry_obj = Industry.find_by(name: industry)
      if industry_obj
        target.industry_id = industry_obj.id
        target.save
      end
    end
  end

  def down
    Buyer.update_all({ industry_id: nil })
    Target.update_all({ industry_id: nil })
  end
end
