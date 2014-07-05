class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def index
    params[:tab] ||= 'All'
    @products = (params[:tab] == 'Hot' ? Product.most_hot : Product.most_recent).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def load_retailer
    @retailer = Retailer.find(params[:retailer_id])
  end
end
