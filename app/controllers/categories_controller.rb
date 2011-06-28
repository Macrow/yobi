class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = Product.products_in_category(@category.id).includes(:major_image).order(get_order_params).page(params[:page])
    @elite_products = Product.products_in_category(@category.id).where(:elite => true).includes(:major_image)
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
  end
end

