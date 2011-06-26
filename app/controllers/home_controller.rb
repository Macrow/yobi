class HomeController < ApplicationController
  def index
    @products = Product.where(:elite => true).includes(:major_image).limit(8)
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    @articles = Article.order("created_at DESC").limit(9)
  end

  def search
    @search = Product.search(params[:search])
    @products = @search.includes(:major_image).order(get_order_params).page(params[:page])
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
  end
end

