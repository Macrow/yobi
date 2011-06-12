class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id], :include => [:products => :major_image])
    @products = @category.products
  end
end

