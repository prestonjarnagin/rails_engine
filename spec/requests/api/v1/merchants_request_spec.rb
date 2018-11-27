require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  describe 'Merchant Business Intelligence' do

    it 'returns top (x) merchants ranked by revenue' do
      get '/api/v1/merchants/most_revenue?quantity=2'
      create_list(:merchant, 3)

      items = JSON.parse(response.body)
      expect(items.count).to eq(2)
    end

  end
end
