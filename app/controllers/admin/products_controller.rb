# coding: utf-8

class Admin::ProductsController < Admin::ApplicationController

  before_filter :get_categories_tree, :get_plists, :only => [:new, :edit, :create, :update]
  cache_sweeper :home_sweeper, :only => [:create, :update, :destroy]
  cache_sweeper :product_sweeper, :only => [:create, :update, :destroy]
  cache_sweeper :category_sweeper, :only => [:create, :update, :destroy]

  def index
    @search = Product.search(params[:search])
    @products = @search.includes(:category).order("created_at DESC").page(params[:page])
    @categories = Category.get_categories_tree(true)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new(:retail_price => 0, :present_price => 0, :stock_count => 0)
    @product.category_id = params[:category_id] unless params[:category_id].nil?
  end

  def edit
    @product = Product.find(params[:id], :include => :properties)
    @tags = Product.tag_counts_on(:tags)
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to [:admin, :products], :notice => "已添加 #{@product.name}！"
    else
      render :action => :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to [:admin, @product], :notice => "已更新 #{@product.name}！"
    else
      render :action => "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to [:admin, :products], :notice => "已删除 #{@product.name}！"
  end

  private

  def get_categories_tree
    @categories = Category.get_categories_tree
  end

  def get_plists
    @plists ||= Plist.all
  end
end

