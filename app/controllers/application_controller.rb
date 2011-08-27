class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_tabs, :get_categories, :initial_search
  rescue_from Exception, :with => :render_all_errors
  
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

  def render_all_errors(e)
    # log_error(e) # log the error
    # notify_about_exception(e) # send the error notification
    # now handle the page
    if e.is_a?(ActionController::RoutingError) || e.is_a?(ActiveRecord::RecordNotFound)
      render_404_error(e)
    else
      render_other_error(e)
    end
  end

  def render_404_error(e)
    render :file => "#{Rails.root}/public/404.html", :layout => "basic", :status => 404
  end

  def render_other_error(e)
    render :file => "#{Rails.root}/public/500.html", :layout => "basic", :status => 500
  end

  private

  def get_tabs
    @tabs ||= Menu.public_menus
  end

  def get_categories
    @categories ||= Category.arrange(:order => :created_at) unless fragment_exist?("categories_navmenu")
  end

  def initial_search
    @search = Product.search(params[:search])
  end
end
