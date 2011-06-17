class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id], :include => [:products => :major_image])
    @products = @category.products
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
  end
end

