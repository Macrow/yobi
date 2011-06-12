class HomeController < ApplicationController
  def index
    @products = Product.where(:elite => false).includes(:major_image).limit(8)
    @good_products = Product.where(:elite => false).includes(:major_image).limit(3)
  end
end

