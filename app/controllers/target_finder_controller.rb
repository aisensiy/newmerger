class TargetFinderController < ApplicationController
  def index
    @industries = Industry.where(is_deprecated: false,
                                 is_secondary: false).includes(:targets, :buyers)
    @industries = @industries.select do |industry|
      industry.targets.size > 0 && industry.buyers.size > 0
    end
  end

  def reference_bargains
    industry_id = params[:industry_id]
    @bargains = Target.where(industry_id: industry_id)
      .includes(bargains: [:buyer, :target]).limit(10).map(&:bargains).flatten
    p @bargains
    render 'reference_bargains', layout: false, content_type: 'text/html'
  end
end
