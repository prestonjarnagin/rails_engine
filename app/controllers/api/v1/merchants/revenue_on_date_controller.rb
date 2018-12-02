class Api::V1::Merchants::RevenueOnDateController < ApplicationController

  def show
    revenue_in_cents = Merchant.revenue_on_date(params[:date])
    revenue_in_dollars = "%.2f" % Rational("#{revenue_in_cents}".to_i,100)
    response = {'data' => {"attributes" => {"revenue" => revenue_in_dollars}}}
    render json: response
  end

end
