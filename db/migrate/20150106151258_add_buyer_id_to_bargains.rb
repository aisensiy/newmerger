class AddBuyerIdToBargains < ActiveRecord::Migration
  def change
    add_column :bargains, :buyer_id, :integer
  end
end
