class AddBargainCounterToBuyer < ActiveRecord::Migration
  def up
    add_column :buyers, :bargains_count, :integer, default: 0
    Buyer.find_each { |buyer| Buyer.reset_counters(buyer.id, :bargains) }
  end

  def down
    remove_column :buyers, :bargains_count
  end
end
