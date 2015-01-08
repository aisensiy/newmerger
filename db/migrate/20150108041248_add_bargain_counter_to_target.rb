class AddBargainCounterToTarget < ActiveRecord::Migration
  def up
    add_column :targets, :bargains_count, :integer, default: 0
    Target.find_each { |target| Target.reset_counters(target.id, :bargains) }
  end

  def down
    remove_column :targets, :bargains_count
  end
end
