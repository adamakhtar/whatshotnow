class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @products = Product.most_recent
  end

  def show
    @product = Product.find(params[:id])
  end

  def load_retailer
    @retailer = Retailer.find(params[:retailer_id])
  end
end
