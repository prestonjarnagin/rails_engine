class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(item_params))
  end

  def show
    if params[:random]
      render json: ItemSerializer.new(Item.order('RANDOM()').first)
    else
      render json: ItemSerializer.new(Item.find_by(item_params))
    end
  end

  def item_params
    params[:unit_price] = (params[:unit_price].to_f*100).to_i if params[:unit_price]
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :updated_at, :created_at)
  end

end
