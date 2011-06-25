# coding: utf-8

module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
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
    output = "您现在的位置："
    output << link_to("首 页", root_path)
    if controller_name =~ /categories|products/i && action_name.downcase == "show"
      @category.ancestors.all.push(@category).each do |c|
        output << " > " << link_to(c.name, c)
      end
    end
    if controller_name == "products" && action_name.downcase == "show"
      output << " > " << @product.name
    end
    if controller_name == "articles" && action_name.downcase == "show"
      output << " > " << "资讯" << " > " << @article.title
    end
    if controller_name =~ /passwords|registrations|sessions/i
      output << " > " << "用户中心"
    end
    content_tag(:div, output.html_safe, :id => "nav-path")
  end

  def show_tabs(categories)
    css = (controller_name == "home" ? "current" : "")
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
end

