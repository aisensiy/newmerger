def normailze_buyers_quantity
  Buyer.find_each do |buyer|
    buyer.cash_reserve_1 /= 10000 unless buyer.cash_reserve_1.nil?
    buyer.cash_reserve_2 /= 10000 unless buyer.cash_reserve_2.nil?
    buyer.cash_reserve_3 /= 10000 unless buyer.cash_reserve_3.nil?
    buyer.market_value /= 10000 unless buyer.market_value.nil?
    buyer.save()
  end
end

normailze_buyers_quantity()
