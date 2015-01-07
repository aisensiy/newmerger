class AddIsDeprecatedToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :is_deprecated, :boolean, default: false
  end
end
