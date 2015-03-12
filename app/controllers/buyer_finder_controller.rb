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
    industry = Industry.find(industry_id)
    if industry.is_secondary?
      @bargains = Target.where(secondary_industry_id: industry_id)
        .includes(bargains: [:buyer, :target]).map(&:bargains).flatten
    else
      @bargains = Target.where(industry_id: industry_id)
        .includes(bargains: [:buyer, :target]).map(&:bargains).flatten
    end
    @bargains.sort! { |a, b| b.sale_at <=> a.sale_at }
    render 'reference_bargains', layout: false, content_type: 'text/html'
  end

  def show_attrs
    @buyer_attrs = APP_CONFIG['buyer_search_attrs']
    @target_attrs = params[:target_attrs]

    industry = Industry.find(@target_attrs[:target_industry])
    if industry.is_secondary?
      candidate_targets = Target.where(is_sold: true, secondary_industry_id: industry.id)
    else
      candidate_targets = Target.where(is_sold: true, industry_id: industry.id)
    end

    target_attrs = @target_attrs.dup
    target_attrs.delete(:target_industry)
    similar_targets = Target.similar_with_index(candidate_targets, target_attrs).map { |v| v[0] }
    similar_buyers = similar_targets.map(&:bargains).flatten.map(&:buyer)

    if industry.is_secondary?
      candidate_buyers = Buyer.where('secondary_industry_id in (?) and id not in (?)',
                                     similar_buyers.map(&:secondary_industry_id).reject{ |i| i.nil? || i.empty? }.uniq,
                                     similar_buyers.map(&:id))
    else
      candidate_buyers = Buyer.where('industry_id in (?) and id not in (?)',
                                     similar_buyers.map(&:industry_id).uniq,
                                     similar_buyers.map(&:id))
    end

    session[:similar_buyer_ids] = similar_buyers.map(&:id)
    session[:is_secondary_industry] = industry.is_secondary?
    @candidate_attr_matrix = @buyer_attrs.map { |buyer_attr, attr_value| [] }
    @similar_attr_matrix = @buyer_attrs.map { |buyer_attr, attr_value| [] }

    @buyer_attrs.keys.each.with_index do |buyer_attr, idx|
      similar_buyers.each do |candidate_buyer|
        @similar_attr_matrix[idx] << [candidate_buyer[buyer_attr], 'special']
      end
    end

    @buyer_attrs.keys.each.with_index do |buyer_attr, idx|
      candidate_buyers.each do |candidate_buyer|
        @candidate_attr_matrix[idx] << [candidate_buyer[buyer_attr], 'normal']
      end
    end
  end

  def show_results
    buyer_attrs = params[:buyer_attrs]
    buyer_attr_weights = params[:buyer_attr_weights]
    # get attr checked
    checked_buyer_attrs = buyer_attrs.select { |item, value| value == 'on' }.keys
    @buyer_attrs = APP_CONFIG['buyer_search_attrs'].select do |key, value|
      checked_buyer_attrs.include? key
    end
    @buyer_attr_weights = @buyer_attrs.map do |attr, attr_name|
      { attr => buyer_attr_weights[attr].to_i }
    end.reduce(:merge)
    # get min max where attr checked
    queries = @buyer_attrs.map do |attr, attr_name|
      attr_min = "#{attr}_min"
      attr_max = "#{attr}_max"
      if buyer_attrs[attr_min].empty? || buyer_attrs[attr_max].empty?
        nil
      else
        "#{attr} >= #{buyer_attrs[attr_min]} " +
        "and #{attr} <= #{buyer_attrs[attr_max]}"
      end
    end.select {|query| !query.nil? }
    # retrieve simliar buyers
    similar_buyers = Buyer.find(session[:similar_buyer_ids])
    candidate_buyers = Buyer.where('industry_id in (?)',
                                   similar_buyers.map(&:industry_id).uniq)
                            .where(queries.join(' and '))
    @result = Buyer.similar(candidate_buyers,
                            similar_buyers,
                            @buyer_attrs.keys,
                            @buyer_attr_weights,
                            k=20).map { |v| v[0] }
  end
end
