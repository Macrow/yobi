class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @product }
        format.js
      else
        format.html { render :controller => :products, :action => :show, :id => @product.id }
        format.js
      end
    end
  end
end

