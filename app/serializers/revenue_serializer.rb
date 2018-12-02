class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_revenue do |object|
    "%.2f" % Rational("#{object.revenue}".to_i,100)
  end
end
