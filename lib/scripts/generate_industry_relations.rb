def generate_industry_relations
  Buyer.find_each do |buyer|
    industry_obj = buyer.industry_obj
    secondary_industry = buyer.secondary_industry
    if !secondary_industry.nil? && secondary_industry.parent_industry.nil?
      secondary_industry.parent_industry = industry_obj
      secondary_industry.save()
    end
  end

  Target.find_each do |target|
    industry_obj = target.industry_obj
    secondary_industry = target.secondary_industry
    if !secondary_industry.nil? && secondary_industry.parent_industry.nil?
      secondary_industry.parent_industry = industry_obj
      secondary_industry.save()
    end
  end
end

generate_industry_relations()
