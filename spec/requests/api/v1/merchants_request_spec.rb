require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it 'sends a single merchant' do
    new_merchant = create(:merchant)

    get "/api/v1/merchants/#{new_merchant.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expected = new_merchant.name
    actual = merchant["name"]
    expect(actual).to eq(expected)
  end

  describe 'Merchant Business Intelligence' do

    xit 'returns top (x) merchants ranked by revenue' do
      create(:merchant)
      get '/api/v1/merchants/most_revenue?quantity=2'
      binding.pry


      items = JSON.parse(response.body)
      expect(items.count).to eq(2)
    end

  end
end
