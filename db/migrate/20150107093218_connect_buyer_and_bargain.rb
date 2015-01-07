class ConnectBuyerAndBargain < ActiveRecord::Migration
  def up
    Bargain.where(buyer_id: nil).find_each do |bargain|
      stock_code = bargain.buyer_stock_code
      buyer = Buyer.find_by(stock_code: stock_code)
      if buyer
        bargain.buyer_id = buyer.id
        bargain.save
      end
    end
  end

  def down
    Bargain.update_all({ buyer_id: nil })
  end
end
