class ProductsController < ApplicationController
  caches_action :show

  def show
    @product = Product.find(params[:id], :include => [:category, [:comments => :user]])
    @category = @product.category
    @relate_products = @product.find_related_tags.limit(3).all
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
  end
end

