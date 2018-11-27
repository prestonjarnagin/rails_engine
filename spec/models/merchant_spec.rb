require 'rails_helper'

RSpec.describe Merchant, type: :model do

  xit '.rank_by_revenue(limit)' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    invoice_item_1 = create(:invoice_item, unit_price: 5, quantity: 1)
    invoice_item_2 = create(:invoice_item, unit_price: 9, quantity: 1)
    invoice_item_3 = create(:invoice_item, unit_price: 2, quantity: 1)
    transaction_1.invoice.invoice_items = [invoice_item_1]
    transaction_2.invoice.invoice_items = [invoice_item_2]
    transaction_3.invoice.invoice_items = [invoice_item_3]


    expected = [invoice_item_2.item.merchant]
    actual = Merchant.ranked_by_revenue(1)
    expect(actual).to eq(expected)

    expected = [invoice_item_2.item.merchant, invoice_item_3.item,merchant]
    actual = Merchant.ranked_by_revenue(2)
    expect(actual).to eq(expected)
  end

end
