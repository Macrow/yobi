class CategorySweeper < ActionController::Caching::Sweeper
  observe Product

  def after_create(product)
    expire_category_show_page(product)
  end

  def after_update(product)
    expire_category_show_page(product)
  end

  def after_destroy(product)
    expire_category_show_page(product)
  end

  private

  def expire_category_show_page(product)
    product.category.ancestors.all.push(product.category).each do |category|
      expire_action(:controller => "/categories", :action => "show", :id => category)
      pages = (category.products.size.to_f / Kaminari.config.default_per_page.to_f).ceil
      (2..pages).to_a.each do |page|
        expire_action(:controller => "/categories", :action => "show", :id => category, :page => page)
      end
    end
  end
end

