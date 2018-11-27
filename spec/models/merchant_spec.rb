require 'rails_helper'

RSpec.describe Merchant, type: :model do

  it '.rank_by_revenue(limit)' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)
    item_1 = create(:item, unit_price: 200)
    item_2 = create(:item, unit_price: 1000)
    item_3 = create(:item, unit_price: 500)
    transaction_1.invoice.items = [item_1]
    transaction_2.invoice.items = [item_2]
    transaction_3.invoice.items = [item_3]

    expected = [item_2.merchant]
    expect(Merchant.ranked_by_revenue(1)).to eq(expected)

    expected = [item_2.merchant, item_3,merchant]
    expect(Merchant.ranked_by_revenue(2)).to eq(expected)
  end

end
