class HomeController < ApplicationController
  def index
    @products = Product.scoped.includes(:images)
  end
end

