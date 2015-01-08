class Bargain < ActiveRecord::Base
  belongs_to :buyer, counter_cache: true
  belongs_to :target, counter_cache: true
end
