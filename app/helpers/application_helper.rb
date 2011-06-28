# coding: utf-8
module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def include_slides_scripts
    content_for :script do
      javascript_include_tag "slidesjs/slides.min.jquery.js"
    end
  end

  def include_slide_js
    %Q{
    <script type='text/javascript'>
      $(document).ready(function() {
		    $('#slides').slides({
			    preload: false,
			    preloadImage: '/images/loading.gif',
			    play: 5000,
			    pause: 2500,
			    hoverPause: true
        });
      });
    </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

  def show_money(number)
    number_to_currency(number, :unit => "￥")
  end

  def product_major_image(product, size = "150x150")
    if product.major_image.nil?
      link_to image_tag("/images/no-pic.png", :size => size), product
    else
      link_to image_tag(product.major_image.image.thumb.url, :size => size), product
    end
  end

  def show_nav_path
    return nil if controller_name == "home" && action_name == "index"
    output = "您现在的位置："
    output << link_to("首 页", root_path)
    if controller_name =~ /categories|products/i && action_name == "show"
      @category.ancestors.all.push(@category).each do |c|
        output << " > " << link_to(c.name, c)
      end
    end
    if controller_name == "products" && action_name == "show"
      output << " > " << @product.name
    end
    if controller_name == "articles" && action_name == "show"
      output << " > " << "资讯" << " > " << @article.title
    end
    if controller_name =~ /passwords|registrations|sessions/i
      output << " > " << "用户中心"
    end
    if controller_name == "home" && action_name == "search"
      output << " > " << "搜索结果"
    end
    content_tag(:div, output.html_safe, :id => "nav-path")
  end

  def show_tabs(categories)
    css = ((controller_name == "home" || controller_name != "categories") ? "current" : "")
    output = content_tag(:li, content_tag(:span, link_to("首 页", root_path)), :class => css)
    categories.each do |c|
      css = ((controller_name == "categories" and params[:id] == c.id.to_s) ? "current" : "")
      output << content_tag(:li, content_tag(:span, link_to(c.name, c)), :class => css)
    end
    output = content_tag(:ul, output, :class => "tabs")
    output.html_safe
  end

  def show_categories_menu(categories)
    categories.map do |category, sub_categories|
      if sub_categories.empty?
        if category.is_root?
          content_tag(:li, "<div class='icon'></div>".html_safe + link_to(category.name, category, :class => "tit"))
        else
          content_tag(:li, link_to(category.name, category))
        end
      else
        if category.is_root?
          content_tag(:li, "<div class='icon'></div>".html_safe + link_to(category.name, category, :class => "tit") + content_tag(:ul, show_categories_menu(sub_categories)))
        else
          content_tag(:li, link_to(category.name, category, :class => "tit") + content_tag(:ul, show_categories_menu(sub_categories)))
        end
      end
    end.join.html_safe
  end

  def show_order_icon_link(order_symbol, order_name, double_order)
    if params[order_symbol].blank?
      order_link_to(order_name, "down", "", "#{order_name}由高到低", url_with_order_params(order_symbol => "down"))
    else
      if double_order
        if params[order_symbol].to_s.strip == "down"
          order_link_to(order_name, "down", "active", "#{order_name}由高到低", url_with_order_params(order_symbol => "up"))
        else params[order_symbol].to_s.strip == "up"
          order_link_to(order_name, "up", "active", "#{order_name}由低到高", url_with_order_params(order_symbol => "down"))
        end
      else
        order_link_to(order_name, "down", "active", "#{order_name}由高到低", "#")
      end
    end
  end

  def show_view_style_icon_links
    output = ""
    %w{grid full list}.each do |style|
      css = params[:view_style] == style ? "current" : ""
      output << link_to(image_tag("#{style}.png"), url_with_query_params(:view_style => style), :class => css, :title => style)
    end
    output.html_safe
  end

  def render_products_by_view_style(products)
    case params[:view_style]
    when nil, "grid"
      render products
    when "full"
      render :partial => "products/product_full", :collection => products, :as => :product
    when "list"
      render :partial => "products/product_list", :collection => products, :as => :product
    else
      render products
    end
  end

  private

  # eg: order_link_to("价 格", "up", "active", "价格由低到高", url)
  def order_link_to(name, direction, active, title, url)
    link_to (content_tag(:span, name, :class => "text").concat(content_tag(:span, "", :class => "arrow #{direction}"))), url, :class => active, :title => title
  end

  def url_with_query_params(options = {})
    request.fullpath.gsub(/\?.+/, "") + "?" + request.query_parameters.merge(options).to_param
  end

  def url_with_order_params(options = {})
    order_params = request.query_parameters.dup
    %w{q p d a}.each { |order| order_params.delete(order) }
    request.fullpath.gsub(/\?.+/, "") + "?" + order_params.merge(options).to_param
  end
end

