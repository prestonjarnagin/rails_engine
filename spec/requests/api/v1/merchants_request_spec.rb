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

  it 'can pick a random merchant' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    get "/api/v1/merchants/random"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    actual = merchant['data']['attributes']['name']
    expect(actual).to eq(merchant_1.name).or eq(merchant_2.name)
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
    before(:each) do
      @merchant_1 = create(:merchant, name: "Merchant 1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @merchant_2 = create(:merchant, name: "Merchant 1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @merchant_3 = create(:merchant, name: "merchant 3", created_at: "2012-05-01 14:53:59 UTC", updated_at: "2012-05-01 14:53:59 UTC")
    end

    it 'returns all by id' do
      parameters = "id=#{@merchant_1.id}"
      get "/api/v1/merchants/find_all?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expected = @merchant_1.name
      actual = merchant['data'][0]['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns all by name' do
      parameters = "name=#{@merchant_1.name}"
      get "/api/v1/merchants/find_all?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      expected = @merchant_1.name
      actual = merchant['data'][0]['attributes']['name']
      expect(actual).to eq(expected)

      expected = @merchant_2.name
      actual = merchant['data'][1]['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns all by created_at' do
      parameters = "created_at=#{@merchant_1.created_at}"
      get "/api/v1/merchants/find_all?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      actual = merchant['data'][0]['attributes']['name']
      expect(actual).to eq(@merchant_1.name).or eq(@merchant_2.name)
      actual = merchant['data'][1]['attributes']['name']
      expect(actual).to eq(@merchant_1.name).or eq(@merchant_2.name)
      expect(merchant['data'][2]).to be_nil
    end

    it 'returns all by updated_at' do
      parameters = "updated_at=#{@merchant_1.updated_at}"
      get "/api/v1/merchants/find_all?#{parameters}"

      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      actual = merchant['data'][0]['attributes']['name']

      actual = merchant['data'][0]['attributes']['name']
      expect(actual).to eq(@merchant_1.name).or eq(@merchant_2.name)
      actual = merchant['data'][1]['attributes']['name']
      expect(actual).to eq(@merchant_1.name).or eq(@merchant_2.name)
      expect(merchant['data'][2]).to be_nil
    end
  end

  describe 'Merchant Business Intelligence' do

    it 'returns top (x) merchants ranked by revenue' do
      setup = create_list(:merchant, 2)
      allow(Merchant).to receive(:ranked_by_revenue).with(2).and_return(Merchant.all)

      get '/api/v1/merchants/most_revenue?quantity=2'
      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expected = setup[0].name
      actual = merchants['data'][0]['attributes']['name']
      expect(actual).to eq(expected)
    end

    it 'returns top (x) merchants ranked by revenue' do
      setup = create_list(:merchant, 2)
      allow(Merchant).to receive(:ranked_by_items_sold_count).with(2).and_return(Merchant.all)

      get '/api/v1/merchants/most_items?quantity=2'
      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expected = setup[0].name
      actual = merchants['data'][0]['attributes']['name']
      expect(actual).to eq(expected)
    end

    xit 'returns total revenue across all merchants for date (x)' do
      date = '2012-01-01'
      total_rev = 10000
      allow(Merchant).to receive(:revenue_on_date).with(date).and_return(total_rev)

      get "/api/v1/merchants/revenue?date=#{date}"
      expect(response).to be_successful

      data = JSON.parse(response.body)

      # actual = data['data']['attributes']['name']
      expect(actual).to eq(100.00)
    end
  end

end
