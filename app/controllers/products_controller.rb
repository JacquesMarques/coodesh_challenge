class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.page(params[:page]).per(params[:per])
    render json: @products
  end

  def show
    render json: @product
  end

  private

  def set_product
    @product = Product.find_by(code: params[:id])
  end
end
