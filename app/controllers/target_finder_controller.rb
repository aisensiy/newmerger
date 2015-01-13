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
    buyer_attrs[:market_value] = buyer_attrs[:market_value].to_f * 10000
    buyer_attrs[:cash_reserve_1] = buyer_attrs[:cash_reserve_1].to_f * 10000
    buyer_attrs[:cash_reserve_2] = buyer_attrs[:cash_reserve_2].to_f * 10000
    buyer_attrs[:cash_reserve_3] = buyer_attrs[:cash_reserve_3].to_f * 10000
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
    @target_attrs = APP_CONFIG['target_search_attrs']
    target_attrs = params[:target_attrs]
    target_attr_weights = params[:target_attr_weights]
    # get attr checked
    checked_target_attrs = target_attrs.select { |item, value| value == 'on' }.keys
    @target_attrs = APP_CONFIG['target_search_attrs'].select do |key, value|
      checked_target_attrs.include? key
    end
    @target_attr_weights = @target_attrs.map do |attr, attr_name|
      target_attr_weights[attr].to_i
    end
    # get min max where attr checked
    queries = @target_attrs.map do |attr, attr_name|
      attr_min = "#{attr}_min"
      attr_max = "#{attr}_max"
      if target_attrs[attr_min].empty? || target_attrs[attr_max].empty?
        nil
      else
        "#{attr} >= #{target_attrs[attr_min]} " +
        "and #{attr} <= #{target_attrs[attr_max]}"
      end
    end.select {|query| !query.nil? }
    # retrieve simliar targets
    similar_targets = Target.find(session[:similar_target_ids])
    candidate_targets = Target.where('industry_id in (?) and id not in (?)',
                                     similar_targets.map(&:industry_id).uniq,
                                     similar_targets.map(&:id))
                              .where(queries.join(' and '))
    @result = Target.similar(candidate_targets,
                             similar_targets,
                             @target_attrs.keys,
                             @target_attr_weights).map { |v| v[0] }
  end
end
