class Buyer < ActiveRecord::Base
  has_many :bargains
  has_many :targets, through: :bargains
  belongs_to :industry_obj, class_name: 'Industry', foreign_key: 'industry_id'
  belongs_to :secondary_industry, class_name: 'Industry'
end
