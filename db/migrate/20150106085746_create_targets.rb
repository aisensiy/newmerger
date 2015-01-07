class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string   "company_name"
      t.string   "stock_code"
      t.string   "status"
      t.string   "contact"
      t.string   "telephone"
      t.string   "target_industry"
      t.float    "target_income",       limit: 24
      t.float    "net_profit",          limit: 24
      t.float    "net_profit_t",        limit: 24
      t.float    "net_profit_t_1",      limit: 24
      t.float    "net_profit_t_2",      limit: 24
      t.float    "net_profit_t_3",      limit: 24
      t.float    "estimate_growth",     limit: 24
      t.float    "estimate_net_profit", limit: 24
      t.float    "expected_value",      limit: 24
      t.float    "market_share",        limit: 24
      t.string   "pe_vc_holder"
      t.float    "capital",             limit: 24
      t.string   "garden"
      t.float    "income_growth",       limit: 24
      t.float    "market_value",        limit: 24
      t.float    "net_asset",           limit: 24
      t.float    "net_capital",         limit: 24
      t.float    "net_profit_growth",   limit: 24
      t.float    "stock_share",         limit: 24
      t.float    "total_debt",          limit: 24
      t.boolean  "is_sold"
      t.timestamps
    end
  end
end
