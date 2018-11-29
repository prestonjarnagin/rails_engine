require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'class methods' do
    before(:each) do
      @ii_1 = create(:invoice_item, unit_price: 5, quantity: 1)
      @ii_1.item.merchant = @ii_1.invoice.merchant
      @ii_1.invoice.transactions.create(attributes_for(:transaction))

      @ii_2 = create(:invoice_item, unit_price: 9, quantity: 1)
      @ii_2.item.merchant = @ii_2.invoice.merchant
      @ii_2.invoice.transactions.create(attributes_for(:transaction))

      @ii_2 = create(:invoice_item, unit_price: 1, quantity: 3)
      @ii_2.item.merchant = @ii_2.invoice.merchant
      @ii_2.invoice.transactions.create(attributes_for(:transaction))

      @ii_3 = create(:invoice_item, unit_price: 4, quantity: 10)
      @ii_3.item.merchant = @ii_3.invoice.merchant
      @ii_3.invoice.transactions.create(attributes_for(:transaction))

      @ii_4 = create(:invoice_item, unit_price: 5, quantity: 2)
      @ii_4.item.merchant = @ii_4.invoice.merchant
      @ii_4.invoice.transactions.create(attributes_for(:transaction))
    end

    it '.rank_by_revenue(limit)' do

      expected_first = @ii_3.item.merchant
      expected_second = @ii_4.item.merchant
      expected_last = @ii_1.item.merchant

      actual_first = Merchant.ranked_by_revenue(4).first
      actual_second = Merchant.ranked_by_revenue(4).second
      actual_last = Merchant.ranked_by_revenue(4).last

      expect(actual_first).to eq(expected_first)
      expect(actual_second).to eq(expected_second)
      expect(actual_last).to eq(expected_last)
    end

    it '.rank_by_items_sold(limit)' do
      expected_first = @ii_3.item.merchant
      expected_second = @ii_2.item.merchant
      expected_last = @ii_4.item.merchant

      actual_first = Merchant.ranked_by_items_sold(3).first
      actual_second = Merchant.ranked_by_items_sold(3).second
      actual_last = Merchant.ranked_by_items_sold(3).last

      expect(actual_first).to eq(expected_first)
      expect(actual_second).to eq(expected_second)
      expect(actual_last).to eq(expected_last)
    end


  end
end
