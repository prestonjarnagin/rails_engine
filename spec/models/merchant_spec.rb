require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'class methods' do
    before(:each) do
      @merchant_1 = create(:merchant)

      @ii_1 = create(:invoice_item, unit_price: 5, quantity: 1)
      @ii_1.invoice.merchant = @merchant_1
      @ii_1.item.merchant = @merchant_1
      @ii_1.invoice.update(created_at: "2012-01-01 14:40:00 UTC")
      @ii_1.invoice.transactions.create(attributes_for(:transaction))

      @ii_2 = create(:invoice_item, unit_price: 9, quantity: 1)
      @ii_2.invoice.merchant = @merchant_1
      @ii_2.item.merchant = @merchant_1
      @ii_2.invoice.update(created_at: "2012-01-01 14:50:00 UTC")
      @ii_2.invoice.transactions.create(attributes_for(:transaction))

      @ii_3 = create(:invoice_item, unit_price: 1, quantity: 3)
      @ii_3.item.merchant = @ii_3.invoice.merchant
      @ii_3.invoice.update(created_at: "2012-01-02 14:54:09 UTC")
      @ii_3.invoice.transactions.create(attributes_for(:transaction))

      @ii_4 = create(:invoice_item, unit_price: 4, quantity: 10)
      @ii_4.item.merchant = @ii_4.invoice.merchant
      @ii_4.invoice.update(created_at: "2012-01-02 14:54:09 UTC")
      @ii_4.invoice.transactions.create(attributes_for(:transaction))

      @ii_5 = create(:invoice_item, unit_price: 5, quantity: 3)
      @ii_5.item.merchant = @ii_5.invoice.merchant
      @ii_5.invoice.update(created_at: "2012-01-03 14:54:09 UTC")
      @ii_5.invoice.transactions.create(attributes_for(:transaction))
    end

    it '.rank_by_revenue(limit)' do
      expected_first = @ii_4.item.merchant
      expected_second = @ii_5.item.merchant
      expected_last = @ii_3.item.merchant

      actual_first = Merchant.ranked_by_revenue(4).first
      actual_second = Merchant.ranked_by_revenue(4).second
      actual_last = Merchant.ranked_by_revenue(4).last

      expect(expected_first).to eq(actual_first)
      expect(expected_second).to eq(actual_second)
      expect(expected_last).to eq(actual_last)
    end

    it '.rank_by_items_sold_count(limit)' do
      expected_first = @ii_4.item.merchant
      expected_second = @ii_3.item.merchant
      expected_last = @ii_5.item.merchant

      actual_first = Merchant.ranked_by_items_sold_count(3).first
      actual_second = Merchant.ranked_by_items_sold_count(3).second
      actual_last = Merchant.ranked_by_items_sold_count(3).last

      expect(expected_first).to eq(actual_first)
      expect(expected_second).to eq(actual_second)
      expect(expected_last).to eq(actual_last)
    end

    it '.revenue_on_date(date)' do
      expected = 14
      actual = Merchant.revenue_on_date("2012-01-01")
      expect(actual).to eq(expected)

      expected = 43
      actual = Merchant.revenue_on_date("2012-01-02")
      expect(actual).to eq(expected)

      expected = 15
      actual = Merchant.revenue_on_date("2012-01-03")
      expect(actual).to eq(expected)
    end

    it 'revenue_by_merchant(merchant_id)' do
      expected = 14
      actual = Merchant.revenue_by_merchant(@merchant_1.id)
      expect(actual).to eq(expected)
    end

    it 'revenue_by_merchant_on_date(merchant_id, date)' do
      expected = 14
      actual = Merchant.revenue_by_merchant_on_date(@merchant_1.id, "2012-01-01")
      expect(actual).to eq(expected)

      expected = 0
      actual = Merchant.revenue_by_merchant_on_date(@merchant_1.id, "2012-02-01")
      expect(actual).to eq(expected)
    end
  end
end
