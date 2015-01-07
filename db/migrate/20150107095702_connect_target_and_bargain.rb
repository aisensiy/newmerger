class ConnectTargetAndBargain < ActiveRecord::Migration
  def up
    Bargain.where(target_id: nil).find_each do |bargain|
      target_name = bargain.target_name
      target = Target.find_by(company_name: target_name)
      if target
        bargain.target_id = target.id
        bargain.save
      end
    end
  end

  def down
    Bargain.update_all({ target_id: nil })
  end
end
