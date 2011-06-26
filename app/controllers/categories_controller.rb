class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = Product.products_in_category(params[:id]).includes(:major_image).order(get_order_params).page(params[:page])
    @elite_products = @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
  end
end

