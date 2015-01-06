class AddTargetIdToBargains < ActiveRecord::Migration
  def change
    add_column :bargains, :target_id, :integer
  end
end
