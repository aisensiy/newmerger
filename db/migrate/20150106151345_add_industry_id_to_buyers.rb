class AddIndustryIdToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :industry_id, :integer
  end
end
