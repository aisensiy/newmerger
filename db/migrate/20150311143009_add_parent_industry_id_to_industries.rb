class AddParentIndustryIdToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :parent_industry_id, :integer
  end
end
