class ChangeIsSecondaryFalseAsDefault < ActiveRecord::Migration
  def change
    change_column :industries, :is_secondary, :boolean, default: false
  end
end
