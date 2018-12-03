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

    before(:each) do
      # Expected return items with identical attributes
      @merchant = create(:merchant)
      @expected_items = create_list(:item, 2,
              name: "Expected Item Name",
              description: "Expected Item Description",
              unit_price: 100,
              merchant_id: @merchant.id,
              updated_at: "2012-09-27T14:54:05.000Z",
              created_at: "2012-09-27T14:54:05.000Z"
            )
      @item_1_id = @expected_items[0].id
      @item_2_id = @expected_items[1].id

      # Unexpected item with unique attributes
      other_merchant = create(:merchant)
      create(:item,
              name: "Unexpected Item Name",
              description: "Unexpected Item Description",
              unit_price: 999,
              merchant_id: other_merchant.id,
              updated_at: "2012-05-28T14:54:05.000Z",
              created_at: "2012-05-28T14:54:05.000Z"
      )
    end

    describe 'returns an array of items given an' do
      it 'id' do
        get "/api/v1/items/find_all?id=#{@item_1_id}"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']
          expect(items[0]['id']).to eq(@item_1_id.to_s)
          expect(items[1]).to be_nil
      end

      it 'name' do
        get "/api/v1/items/find_all?name=#{@expected_items[0].name}"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end

      it 'description' do
        get "/api/v1/items/find_all?description=#{@expected_items[0].description}"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end

      it 'unit price' do
        get "/api/v1/items/find_all?unit_price=#{@expected_items[0].unit_price}"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end

      it 'merchant_id' do
        get "/api/v1/items/find_all?merchant_id=#{@expected_items[0].merchant_id}"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end

      it 'created_at' do
        get "/api/v1/items/find_all?created_at=2012-09-27T14:54:05.000Z"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end
      it 'updated_at' do
        get "/api/v1/items/find_all?updated_at=2012-09-27T14:54:05.000Z"
          expect(response).to be_successful

          items = JSON.parse(response.body)['data']

          expect(items[0]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[1]['id']).to eq(@item_1_id.to_s).or eq(@item_2_id.to_s)
          expect(items[2]).to be_nil
      end
    end
  end

  describe 'Relationships' do

  end

  describe 'Busines Intelligence' do

  end

end
