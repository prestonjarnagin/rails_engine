class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    favorite_customer = Merchant.favorite_customer(params[:merchant_id].to_i)
    render json: CustomerSerializer.new(favorite_customer)
  end
end
