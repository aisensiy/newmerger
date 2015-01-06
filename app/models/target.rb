class Target < ActiveRecord::Base
  belongs_to :industry_obj, class_name: 'Industry'
  has_many :bargains
end
