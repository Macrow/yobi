class HomeSweeper < ActionController::Caching::Sweeper
  observe Product, Article, Category

  def after_create(record)
    expire_homepage
  end

  def after_update(record)
    expire_homepage
  end

  def after_destroy(record)
    expire_homepage
  end

  private

  def expire_homepage
    expire_page(:controller => "/home", :action => "index")
  end
end

