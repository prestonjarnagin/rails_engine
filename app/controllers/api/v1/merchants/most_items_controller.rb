class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.ranked_by_items_sold_count(params[:quantity].to_i))
  end

end
