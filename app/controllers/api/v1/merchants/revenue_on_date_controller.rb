class Api::V1::Merchants::RevenueOnDateController < ApplicationController

  def show
    revenue = Revenue.new(Merchant.revenue_on_date(params[:date]))
    render json: RevenueSerializer.new(revenue)
  end

end
