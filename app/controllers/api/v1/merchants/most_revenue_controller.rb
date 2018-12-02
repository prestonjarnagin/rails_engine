class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.ranked_by_revenue(params[:quantity].to_i))
  end

end
