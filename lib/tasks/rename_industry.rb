def rename_industry(from, to, is_secondary=false)
  from_industry = Industry.find_by(name: from, is_secondary: is_secondary)
  buyers_with_oldname = from_industry.buyers
  targets_with_oldname = from_industry.targets
  to_industry = Industry.find_by(name: to, is_secondary: is_secondary)
  (buyers_with_oldname + targets_with_oldname).each do |entity|
    if is_secondary
      entity.secondary_industry_id = to_industry.id
    else
      entity.industry_id = to_industry.id
    end
    entity.save
  end
  from_industry.destroy
end

rename_industry('金融、保险业', '金融业')
rename_industry('金融保险业', '金融业')
rename_industry('采掘业', '采矿业')
rename_industry('租赁和商业服务业', '租赁和商务服务业')
rename_industry('电力、煤气及水的生产和供应业', '电力、热力、燃气及水生产和供应业')
rename_industry('生态保护和环境治理', '生态保护和环境治理业')
rename_industry('水利、环境和公告设施管理业', '水利、环境和公共设施管理业')
rename_industry('批发和零售贸易', '批发和零售业')
rename_industry('交通运输、仓储业和邮政业', '交通运输、仓储和邮政业')
rename_industry('交通运输、仓储业', '交通运输、仓储和邮政业')
