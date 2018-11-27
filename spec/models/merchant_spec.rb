require 'rails_helper'

RSpec.describe Merchant, type: :model do

  it '.rank_by_revenue(limit)' do
    item_1 = create(:item, unit_price: 200)
    item_2 = create(:item, unit_price: 1000)
    item_3 = create(:item, unit_price: 500)
    binding.pry
    

    invoice_1 = create(:invoice, merchant: item_1.merchant)
    invoice_2 = create(:invoice, merchant: item_2.merchant)
    invoice_3 = create(:invoice, merchant: item_3.merchant)

    binding.pry

    expected = [item_2.merchant]
    expect(Merchant.ranked_by_revenue(1)).to eq(expected)

    expected = [item_2.merchant, item_3,merchant]
    expect(Merchant.ranked_by_revenue(2)).to eq(expected)
  end

end
