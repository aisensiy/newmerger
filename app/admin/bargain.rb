ActiveAdmin.register Bargain do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    id_column
    column :buyer, sortable: :buyer_id do |bargain|
      if bargain.buyer
        link_to bargain.buyer.company_name, edit_admin_buyer_path(bargain.buyer)
      else
        ''
      end
    end
    column :buyer_name
    column :target, sortable: :target_id do |bargain|
      if bargain.target
        link_to bargain.target.company_name, edit_admin_target_path(bargain.target)
      else
        ''
      end
    end
    column :target_name
    column :value_at
    column :bargain_value
    column :year
    actions
  end

end
