module SimilarCalculatable extend ActiveSupport::Concern
  def transpose(matrix)
    m = matrix.size
    n = matrix[0].size

    newmatrix = n.times.map { Array.new(m) }
    m.times do |i|
      n.times do |j|
        newmatrix[j][i] = matrix[i][j]
      end
    end

    newmatrix
  end

  def normalize(vector, weights=nil)
    min_value = vector.min
    range = vector.max - min_value
    vector = vector.map do |v|
      range == 0 ? 1.0 : 1.0 * (v - min_value) / range
    end
    unless weights.nil?
      vector = vector.map.with_index do |v, i|
        v * weights[i].to_f
      end
    end
    vector
  end

  def cal_distance(a, b)
    n = a.size
    n.times.map { |i| (a[i] - b[i]) ** 2 }.reduce(&:+)
  end

end
