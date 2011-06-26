class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_categories, :initial_search

  protected

  def get_order_params
    order_string = %w{quantity present_price discount created_at}
    order = "products.created_at DESC"
    %w{q p d a}.each_with_index do |p, i|
      unless params[p].blank?
        if params[p] == "down"
          order = "products.#{order_string[i]} DESC"
          order = "products.#{order_string[i]} ASC" if p == "d"
          break
        elsif params[p] == "up" and p == "p"
          order = "products.#{order_string[i]} ASC"
          break
        end
      end
    end
    order
  end

  private
  def get_categories
    @categories ||= Category.arrange(:order => :created_at)
    @root_categories ||= @categories.keys
  end

  def initial_search
    @search = Product.search(params[:search])
  end
end

