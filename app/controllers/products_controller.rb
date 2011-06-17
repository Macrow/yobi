class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id], :include => :category)
    @category = @product.category
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    respond_to do |format|
      format.html
    end
  end
end

