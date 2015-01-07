class Target < ActiveRecord::Base
  belongs_to :industry_obj, class_name: 'Industry', foreign_key: 'industry_id'
  has_many :bargains
end
