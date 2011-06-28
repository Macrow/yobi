class CategoriesController < ApplicationController
  #caches_page :show

  def show
    @category = Category.find(params[:id])
    @products = Product.products_in_category(params[:id]).includes(:major_image).order(get_order_params).page(params[:page])
    @elite_products = Product.products_in_category(params[:id]).where(:elite => true).includes(:major_image)
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
  end
end

