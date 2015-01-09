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

  def normalize(vector)
    min_value = vector.min
    range = vector.max - min_value
    vector.map do |v|
      1.0 * (v - min_value) / range
    end
  end

  def cal_distance(a, b)
    n = a.size
    n.times.map { |i| (a[i] - b[i]) ** 2 }.reduce(&:+)
  end

end
