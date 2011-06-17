class Admin::ProductsController < Admin::ApplicationController
  before_filter :get_categories_tree, :only => [:new, :edit, :create, :update]

  def index
    search = params[:search].nil? ? "" : params[:search]
    search = "%" + search + "%"
    @products = Product.where(["name LIKE ?", search]).order("created_at DESC").includes(:category).page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new(:retail_price => 0, :present_price => 0, :stock_count => 0)
    @product.category_id = params[:category_id] unless params[:category_id].nil?
  end

  def edit
    @product = Product.find(params[:id])
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
end

