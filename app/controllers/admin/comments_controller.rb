# coding: utf-8

class Admin::CommentsController < Admin::ApplicationController

  before_filter :find_product_or_user
  cache_sweeper :product_sweeper, :only => [:update, :destroy]

  def index
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  def destory_all
    if @owner.instance_of?(Product)
      expire_action(:controller => "/products", :action => "show", :id => @owner)
      Comment.delete_all(:commentable_id => @owner.id, :commentable_type => @owner.class.to_s)
    elsif @owner.instance_of?(User)
      @owner.comments.each do |c|
        expire_action(:controller => "/products", :action => "show", :id => c.commentable) if c.commentable.is_a?(Product)
      end
      Comment.delete_all(:user_id => @owner.id)
    end
    redirect_to [:admin, @owner], :notice => "成功删除 #{@owner_name} 全部评论！"
  end

  private

  def find_product_or_user
    unless params[:product_id].nil?
      if action_name =~ /index/i
        @product = Product.find(params[:product_id], :include => [:comments => :user])
      else
        @product = Product.find(params[:product_id])
      end
      @owner = @product
      @owner_name = @product.name
      @owner_destroy_all_comments_path = destory_all_admin_product_comments_path
    end
    unless params[:user_id].nil?
      if action_name =~ /index/i
        @user = User.find(params[:user_id], :include => [:comments => :commentable])
      else
        @user = User.find(params[:user_id])
      end
      @owner = @user
      @owner_name = @user.user_name
      @owner_destroy_all_comments_path = destory_all_admin_user_comments_path
    end
  end
end

