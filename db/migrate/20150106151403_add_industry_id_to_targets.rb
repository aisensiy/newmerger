class AddIndustryIdToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :industry_id, :integer
  end
end
