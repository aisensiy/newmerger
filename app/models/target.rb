class Target < ActiveRecord::Base
  extend SimilarCalculatable

  belongs_to :industry_obj, class_name: 'Industry', foreign_key: 'industry_id'
  belongs_to :secondary_industry, class_name: 'Industry'
  has_many :bargains

  def self.similar(candidates, similar_targets, attrs, k=10)
    vectors = similar_targets.map do |target|
      target.attributes.select { |k, v| attrs.include? k }.values.map do |v|
        v.nil? ? 0 : v
      end
    end

    center = attrs.size.times.map do |i|
      sum = 1.0 * vectors.size.times.map { |j| vectors[j][i] }.reduce(&:+)
      sum / similar_targets.size
    end

    candidate_matrix = candidates.map do |candidate|
      candidate.attributes.select { |k, v| attrs.include? k }.values.map do |v|
        v.nil? ? 0 : v
      end
    end

    matrix = [center] + candidate_matrix
    normalized_matrix = transpose(transpose(matrix).map { |v| normalize(v) })

    distances = (1..candidates.size).map do |i|
      [cal_distance(normalized_matrix[0], normalized_matrix[i]), candidates[i - 1]]
    end.sort { |a, b| a[0] <=> b[0] }

    distances.map { |d| [d[1], d[0]] }[0...k]
  end

  def self.similar_with_index(candidates, attrs, k=5)
    target = attrs.values.map(&:to_f)
    attr_keys = attrs.keys
    candidate_matrix = candidates.map do |candidate|
      candidate.attributes.select { |k, v| attr_keys.include? k }.values.map do |v|
        v.nil? ? 0 : v.to_f
      end
    end

    matrix = [target] + candidate_matrix
    normalized_matrix = transpose(transpose(matrix).map { |v| normalize(v) })

    distances = (1..candidates.size).map do |i|
      [cal_distance(normalized_matrix[0], normalized_matrix[i]), candidates[i - 1]]
    end.sort { |a, b| a[0] <=> b[0] }

    distances.map { |d| [d[1], d[0]] }[0...k]
  end
end
