class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id], :include => [:products => :major_image])
    @products = @category.products.order("created_at DESC").page(params[:page]).per(12)
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    @elite_products = Product.where(:elite => true).order("created_at DESC").includes(:major_image).limit(3)
  end
end

