class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :merchant_id
  attribute :unit_price do |object|
    "%.2f" % Rational("#{object.unit_price}".to_i,100)
  end
end
