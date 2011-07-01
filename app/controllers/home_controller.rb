class HomeController < ApplicationController
  caches_page :index
  def index
    @elite_products = Product.where(:elite => true).includes(:major_image).limit(8)
    @price_off_products = Product.order("discount DESC").includes(:major_image).limit(8)
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
    @articles = Article.order("created_at DESC").limit(8)
  end

  def search
    @search = Product.search(params[:search])
    @products = @search.includes(:major_image).order(get_order_params).page(params[:page])
    @quantity_products = Product.order("quantity DESC").includes(:major_image).limit(3)
  end

  # TODO: implement sitemap support
  #       sitemap.html & sitemap.xml
  #       remember update robots.txt file
  def sitemap
    respond_to do |format|
      format.html
      format.xml
    end
  end
end

