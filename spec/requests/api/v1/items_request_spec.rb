require 'rails_helper'

RSpec.describe 'Items API' do

  before(:each) do
    @expected_item = create(:item, updated_at: "2012-03-27T14:54:05.000Z", created_at: "2012-03-27T14:54:05.000Z")
  end

  describe 'Single Finders' do

    describe 'returns an item given an' do
      it 'id' do
        get "/api/v1/items/find?id=#{@expected_item.id}"
          expect(response).to be_successful

          item = JSON.parse(response.body)['data']
          expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'name' do
        get "/api/v1/items/find?name=#{@expected_item.name}"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'description' do
        get "/api/v1/items/find?description=#{@expected_item.description}"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'unit price' do
        get "/api/v1/items/find?unit_price=#{@expected_item.unit_price}"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expected_price = "%.2f" % Rational("#{@expected_item.unit_price}".to_i,100)
        expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'merchant_id' do
        get "/api/v1/items/find?merchant_id=#{@expected_item.merchant_id}"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'created_at' do
        get "/api/v1/items/find?created_at=2012-03-27T14:54:05.000Z"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expect(item['id']).to eq @expected_item.id.to_s
      end

      it 'updated_at' do
        get "/api/v1/items/find?updated_at=2012-03-27T14:54:05.000Z"
        expect(response).to be_successful

        item = JSON.parse(response.body)['data']
        expect(item['id']).to eq @expected_item.id.to_s
      end
    end
  end

  describe 'Multi Finders' do
    describe 'returns an array of items given an' do
      it 'id' do

      end

      it 'name' do

      end

      it 'description' do

      end

      it 'unit price' do

      end

      it 'merchant_id' do

      end

      it 'created_at' do

      end
      it 'updated_at' do

      end
    end
  end

  describe 'Relationships' do

  end

  describe 'Busines Intelligence' do

  end

end
