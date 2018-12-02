class ItemSerializer
  include ActionView::Helpers::NumberHelper
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
  attribute :unit_price do |object|
    "%.2f" % Rational("#{object.unit_price}".to_i,100)
  end
end
