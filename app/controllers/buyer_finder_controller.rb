class BuyerFinderController < ApplicationController
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

  def show_attrs
    @buyer_attrs = [:market_value, :pe, :growth_ratio_1, :growth_ratio_2, :growth_ratio_3, :roe, :ssh_prop, :cash_reserve_1, :cash_reserve_2, :cash_reserve_3]
    @target_attrs = params[:target_attrs]
    candidate_targets = Target.where(is_sold: true,
                                     industry_id: @target_attrs[:target_industry])

    target_attrs = @target_attrs.dup
    target_attrs.delete(:target_industry)
    similar_targets = Target.similar_with_index(candidate_targets, target_attrs).map { |v| v[0] }

    similar_buyers = similar_targets.map(&:bargains).flatten.map(&:buyer)
    candidate_buyers = Buyer.where('industry_id in (?) and id not in (?)',
                  similar_buyers.map(&:industry_id).uniq, similar_buyers.map(&:id))
    @attr_matrix = @buyer_attrs.map { |buyer_attr| [] }
    @buyer_attrs.each_with_index do |buyer_attr, idx|
      candidate_buyers.each do |candidate_buyer|
        @attr_matrix[idx] << candidate_buyer[buyer_attr]
      end
    end
  end

  def show_results
    @buyer_attrs = params[:buyer_attrs]
  end
end
