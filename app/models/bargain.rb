class Bargain < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :target
end
