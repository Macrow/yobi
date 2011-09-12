class Admin::ImagesController < Admin::ApplicationController
  
  cache_sweeper :home_sweeper, :only => [:create, :update, :destroy]
  cache_sweeper :product_sweeper, :only => [:create, :update, :destroy]

  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.build(params[:image])
    @image.is_major = true if @product.major_image.nil?

    respond_to do |format|
      if @image.save
        format.js
      else
        format.js
      end
    end
  end

  def update
    @product = Product.find(params[:product_id], :include => :major_image)
    @image = Image.find(params[:id])
    @orgin_major_image = @product.major_image
    @orgin_major_image.update_attribute(:is_major, false) unless @orgin_major_image.nil?

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.js
    end
  end
end

