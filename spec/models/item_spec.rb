require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'class methods' do

    it '.rank_by_revenue' do
      ii_1 = create(:invoice_item, quantity: 5, unit_price: 10)
      ii_2 = create(:invoice_item, quantity: 3, unit_price: 3)
      ii_3 = create(:invoice_item, quantity: 1, unit_price: 5)
      ii_4 = create(:invoice_item, quantity: 2, unit_price: 1)
      ii_5 = create(:invoice_item, quantity: 1, unit_price: 1)
      ii_6 = create(:invoice_item, quantity: 10, unit_price: 10)

      expected = [ii_6.item, ii_1.item, ii_2.item]
      actual = Item.rank_by_revenue(3)
      expect(actual).not_to eq(expected)
    end
  end

end
