class Industry < ActiveRecord::Base
  has_many :targets
  has_many :buyers
end
