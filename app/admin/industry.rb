ActiveAdmin.register Industry do


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
    column :name
    column :count_of_buyers do |industry|
      industry.buyers.count
    end
    column :count_of_targets do |industry|
      industry.targets.count
    end
    column :is_secondary
    actions
  end

end
