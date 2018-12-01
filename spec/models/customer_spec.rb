require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'class methods' do
    it '.favorite_merchant(customer_id)' do
      merchant_1 = create(:merchant)
      customer = create(:customer)
      item_1 = create(:item, merchant: merchant_1)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
      create(:invoice_item, invoice: invoice_1, item: item_1)

      expected = merchant_1
      actual = Customer.favorite_merchant(customer.id)

      expect(actual).to eq(expected)

      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)
      invoice = create(:invoice, merchant: merchant_2, customer: customer)
      create(:invoice_item, invoice: invoice, item: item_2)
      create(:invoice_item, invoice: invoice, item: item_2)

      expected = merchant_2
      actual = Customer.favorite_merchant(customer.id)

      expect(actual).to eq(expected)
    end
  end

end
