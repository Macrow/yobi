class Admin::ProductsController < Admin::ApplicationController
  def index
    @products = Product.order("created_at").page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to :index, :notice => "Good."
    else
      render :action => :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to [:admin, @product], :notice => 'Product was successfully updated.'
    else
      render :action => "edit"
    end
  end
end

