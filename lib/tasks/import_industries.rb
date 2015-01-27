require 'csv'

def get_industries_from_csv(csvs)
  puts "get industries..."
  industries = []
  secondary_industries = []
  csvs.each do |csvfile|
    rows = CSV.read(csvfile, headers: true)
    rows.each do |row|
      industries << row['industry'] unless row['industry'].nil?
      secondary_industries << row['secondary_industry'] unless row['secondary_industry'].nil?
    end
  end
  return industries.uniq.sort, secondary_industries.uniq.sort
end

def recreate_industry_table(industries, secondary_industries)
  puts "recreate industry table..."
  Industry.delete_all
  industries.each { |industry| Industry.create(name: industry) }
  secondary_industries.each do |secondary_industry|
    Industry.create(name: secondary_industry, is_secondary: true)
  end
end

def remapping_industry_and_object(file_name, object_name)
  puts "remapping #{object_name} from #{file_name}..."
  obj = object_name.constantize
  col_name = object_name.downcase + '_name'
  rows = CSV.read(file_name, headers: true)
  rows.each do |row|
    next if row['industry'].nil?
    name = row[col_name]
    industry = Industry.find_by(name: row['industry'],
                                is_secondary: false)
    secondary_industry = Industry.find_by(name: row['secondary_industry'],
                                          is_secondary: true)
    item = obj.find_by(company_name: name)
    if item
      item.industry_id = industry.id
      item.secondary_industry_id = secondary_industry.id unless secondary_industry.nil?
      item.save
    end
  end
end

buyer_filename = ARGV[0]
target_filename = ARGV[1]
bargain_filename = ARGV[2]


industries, s_industries = get_industries_from_csv([buyer_filename, target_filename, bargain_filename])
recreate_industry_table(industries, s_industries)
remapping_industry_and_object(buyer_filename, 'Buyer')
remapping_industry_and_object(target_filename, 'Target')
remapping_industry_and_object(bargain_filename, 'Target')
