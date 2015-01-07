# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150107101729) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "bargains", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "buyer_id"
    t.integer  "target_id"
  end

  create_table "buyers", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "industry_id"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "industry_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
