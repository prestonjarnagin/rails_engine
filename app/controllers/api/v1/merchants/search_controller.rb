class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(merchant_params))
  end

  def show
    if params[:random]
      render json: MerchantSerializer.new(Merchant.order('RANDOM()').first)
    else
      render json: MerchantSerializer.new(Merchant.find_by(merchant_params))
    end
  end

  private
  def merchant_params
    params.permit(:id, :name, :updated_at, :created_at)
  end

end
