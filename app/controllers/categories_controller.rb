class CategoriesController < ApplicationController
  caches_action :show
  
  def show
    @category = Category.find(params[:id])
    @products = Product.products_in_category(@category.id).includes(:major_image).order(get_order_params).page(params[:page])
    @elite_products = Product.products_in_category(@category.id).where(:elite => true).includes(:major_image)
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
  end
  
  def search
    @category = Category.find(params[:id])
    @products = Product.products_in_category(@category.id).includes(:major_image).order(get_order_params).page(params[:page])
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
    @elite_products = Product.products_in_category(@category.id).where(:elite => true).includes(:major_image)
  end
end