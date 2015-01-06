class Buyer < ActiveRecord::Base
  has_many :bargains
  has_many :targets, through: :bargains
  belongs_to :industry_obj, class_name: 'Industry'
end
