class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.includes(:major_image).order(get_order_params).page(params[:page]).per(12)
    @good_products = Product.where(:elite => true).includes(:major_image).limit(3)
    @elite_products = Product.where(:elite => true).order("created_at DESC").includes(:major_image).limit(3)
  end

  private

  def get_order_params
    order_string = %w{quantity present_price discount created_at}
    order = "created_at DESC"
    %w{q p d a}.each_with_index do |p, i|
      unless params[p].blank?
        if params[p] == "down"
          order = "#{order_string[i]} DESC"
          order = "#{order_string[i]} ASC" if p == "d"
          break
        elsif params[p] == "up" and p == "p"
          order = "#{order_string[i]} ASC"
          break
        end
      end
    end
    order
  end
end

