class HomeController < ApplicationController
  def index
    @products = Product.where(:elite => true).includes(:major_image).limit(8)
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    @articles = Article.order("created_at DESC").limit(8)
  end
end

