class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id], :include => [:category, [:comments => :user]])
    @category = @product.category
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    @relate_products = @product.find_related_tags.limit(3).all
  end
end

