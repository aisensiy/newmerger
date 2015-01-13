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
    render 'reference_bargains', layout: false, content_type: 'text/html'
  end

  def show_attrs
    @target_attrs = APP_CONFIG['target_search_attrs']
    @buyer_attrs = params[:buyer_attrs]
    candidate_buyers = Buyer.where('bargains_count > 0')
                            .where(industry_id: @buyer_attrs[:buyer_industry])

    buyer_attrs = @buyer_attrs.dup
    buyer_attrs.delete(:buyer_industry)
    similar_buyers = Buyer.similar_with_index(candidate_buyers, buyer_attrs).map { |v| v[0] }

    similar_targets = similar_buyers.map(&:bargains).flatten.map(&:target)
    session[:similar_target_ids] = similar_targets.map(&:id)
    @attr_matrix = @target_attrs.map { |target_attr, attr_value| [] }
    @target_attrs.keys.each.with_index do |target_attr, idx|
      similar_targets.each do |candidate_target|
        @attr_matrix[idx] << candidate_target[target_attr]
      end
    end
  end

  def show_results

  end
end
