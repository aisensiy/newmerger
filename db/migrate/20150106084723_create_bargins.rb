class CreateBargins < ActiveRecord::Migration
  def change
    create_table :bargins do |t|
      t.string   "payment_type"
      t.string   "consultant"
      t.integer  "year"
      t.date     "sale_at"
      t.string   "buyer_name"
      t.string   "buyer_stock_code"
      t.string   "buyer_industry"
      t.string   "bargain_type"
      t.float    "support_fund",          limit: 24
      t.string   "support_fund_use"
      t.float    "bargain_value",         limit: 24
      t.date     "value_at"
      t.float    "target_estimate_value", limit: 24
      t.string   "target_name"
      t.string   "target_industry"
      t.string   "target_business"
      t.float    "target_net_asset",      limit: 24
      t.float    "target_income",         limit: 24
      t.float    "net_profit",            limit: 24
      t.float    "net_profit_t",          limit: 24
      t.float    "net_profit_t_1",        limit: 24
      t.float    "net_profit_t_2",        limit: 24
      t.float    "net_profit_t_3",        limit: 24
      t.float    "capital_based_value",   limit: 24
      t.float    "profit_based_value",    limit: 24
      t.float    "market_based_value",    limit: 24
      t.string   "pricing_method"
      t.float    "growth_ratio",          limit: 24
      t.float    "static_pe",             limit: 24
      t.float    "dynamic_pe",            limit: 24
      t.float    "ps",                    limit: 24
      t.float    "pb",                    limit: 24
      t.text     "memo"
      t.timestamps
    end
  end
end
