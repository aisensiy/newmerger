class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string   "stock_code"
      t.string   "company_name"
      t.string   "actual_controller"
      t.float    "ssh_prop",          limit: 24
      t.string   "owner_type"
      t.integer  "bargain_freq"
      t.date     "ipo_at"
      t.date     "start_at"
      t.string   "industry"
      t.text     "main_product"
      t.string   "main_product_type"
      t.string   "region"
      t.float    "cash_reserve_2",    limit: 24
      t.float    "cash_reserve_3",    limit: 24
      t.float    "cash_reserve_1",    limit: 24
      t.float    "growth_ratio_1",    limit: 24
      t.float    "growth_ratio_2",    limit: 24
      t.float    "growth_ratio_3",    limit: 24
      t.float    "net_profit",        limit: 24
      t.float    "roe",               limit: 24
      t.string   "concept_sector"
      t.integer  "row_index"
      t.float    "pe",                limit: 24
      t.float    "market_value",      limit: 24
      t.float    "pb",                limit: 24
      t.timestamps
    end
  end
end
