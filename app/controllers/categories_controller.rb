class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id], :include => :products)
    @products = @category.products
  end
end

