ActiveAdmin.register Target do


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
    column :stock_code
    column :company_name
    column :industry_obj, sortable: :industry_id do |buyer|
      if buyer.industry_obj
        link_to buyer.industry_obj.name, edit_admin_industry_path(buyer.industry_id)
      else
        ''
      end
    end
    column :target_industry
    column :is_sold
    column :net_profit
    column :estimate_growth
    column :net_profit_t_1
    column :net_profit_t_2
    column :net_profit_t_3
    column :target_income
    actions
  end

end
