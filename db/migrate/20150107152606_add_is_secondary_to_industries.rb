class AddIsSecondaryToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :is_secondary, :boolean
  end
end
