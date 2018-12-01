require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'class methods' do

    before(:each) do
      @ii_1 = create(:invoice_item, quantity: 5, unit_price: 10)
      @ii_1.invoice.transactions.create(attributes_for(:transaction))

      @ii_2 = create(:invoice_item, quantity: 1, unit_price: 5)
      @ii_2.invoice.transactions.create(attributes_for(:transaction))

      @ii_3 = create(:invoice_item, quantity: 3, unit_price: 3)
      @ii_3.invoice.transactions.create(attributes_for(:transaction))

      @ii_4 = create(:invoice_item, quantity: 8, unit_price: 1)
      @ii_4.invoice.transactions.create(attributes_for(:transaction))

      @ii_5 = create(:invoice_item, quantity: 1, unit_price: 1)
      @ii_5.invoice.transactions.create(attributes_for(:transaction))

      @ii_6 = create(:invoice_item, quantity: 10, unit_price: 10)
      @ii_6.invoice.transactions.create(attributes_for(:transaction))
    end

    it '.rank_by_revenue' do
      expected_first = @ii_6.item
      expected_second = @ii_1.item
      expected_third = @ii_3.item
      actual = Item.rank_by_revenue(3)
      expect(actual.first).to eq(expected_first)
      expect(actual.second).to eq(expected_second)
      expect(actual.third).to eq(expected_third)
    end

    it '.rank_by_quantity_sold' do
      expected_first = @ii_6.item
      expected_second = @ii_4.item
      expected_third = @ii_1.item
      actual = Item.rank_by_quantity_sold(3)

      expect(actual.first).to eq(expected_first)
      expect(actual.second).to eq(expected_second)
      expect(actual.third).to eq(expected_third)
    end
  end

end
