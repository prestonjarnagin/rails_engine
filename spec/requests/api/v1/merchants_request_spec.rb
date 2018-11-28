require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants['data'].count).to eq(3)
  end

  it 'sends a single merchant' do
    new_merchant = create(:merchant)

    get "/api/v1/merchants/#{new_merchant.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expected = new_merchant.name
    actual = merchant['data']['attributes']['name']
    expect(actual).to eq(expected)
  end

  describe 'Single Finders' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
    end

    it 'returns by id' do
      parameters = "id=#{@merchant_1.id}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_1.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)

      parameters = "id=#{@merchant_2.id}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_2.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns by name' do
      parameters = "name=#{@merchant_1.name}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_1.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns by created_at' do
      @merchant_1.update(created_at: "2012-03-27 14:53:59 UTC")
      @merchant_2.update(created_at: "2012-03-24 14:53:59 UTC")

      parameters = "created_at=#{@merchant_1.created_at}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_1.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)

      parameters = "created_at=#{@merchant_2.created_at}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_2.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns by updated_at' do
      @merchant_1.update(updated_at: "2012-03-27 14:53:59 UTC")
      @merchant_2.update(updated_at: "2012-03-24 14:53:59 UTC")

      parameters = "updated_at=#{@merchant_1.updated_at}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_1.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)

      parameters = "updated_at=#{@merchant_2.updated_at}"
      get "/api/v1/merchants/find?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)

      expected = @merchant_2.name
      actual = merchant['data']['attributes']['name']
      expect(actual).to eq(expected)
    end
  end

  describe 'Multi Finders' do

  end

  describe 'Merchant Business Intelligence' do

    xit 'returns top (x) merchants ranked by revenue' do
      create(:merchant)
      get '/api/v1/merchants/most_revenue?quantity=2'


      items = JSON.parse(response.body)
      expect(items.count).to eq(2)
    end
  end

end
