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
    selectable_column
    id_column
    column :name
    column :count_of_buyers do |industry|
      industry.buyers.count
    end
    column :count_of_targets do |industry|
      industry.targets.count
    end
    column :is_secondary
    column :is_deprecated
    actions
  end

  batch_action :set_deprecated do |ids|
    Industry.where('id in (?)', ids).update_all(is_deprecated: true)
    redirect_to :back, alert: "The industries have been set deprecated."
  end
  batch_action :destroy, false

end
