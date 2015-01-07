class Target < ActiveRecord::Base
  belongs_to :industry_obj, class_name: 'Industry', foreign_key: 'industry_id'
  belongs_to :secondary_industry, class_name: 'Industry'
  has_many :bargains
end
