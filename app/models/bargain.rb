class Bargain < ActiveRecord::Base
  belongs_to :buyer, counter_cache: true
  belongs_to :target
end
