class Industry < ActiveRecord::Base
  has_many :targets
  has_many :buyers
  has_many :secondary_targets, class_name: 'Target', foreign_key: 'secondary_industry_id'
  has_many :secondary_buyers, class_name: 'Buyer', foreign_key: 'secondary_industry_id'
  has_many :child_industries, class_name: 'Industry', foreign_key: 'parent_industry_id'
  belongs_to :parent_industry, class_name: 'Industry'
end
