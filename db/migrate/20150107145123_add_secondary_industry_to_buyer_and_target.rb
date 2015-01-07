class AddSecondaryIndustryToBuyerAndTarget < ActiveRecord::Migration
  def change
    add_column :buyers, :secondary_industry_id, :integer
    add_column :targets, :secondary_industry_id, :integer
  end
end
