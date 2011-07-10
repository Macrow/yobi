class StaticpageSweeper < ActionController::Caching::Sweeper
  observe Staticpage

  def after_update(staticpage)
    expire_staticpage(staticpage)
  end

  def after_destroy(staticpage)
    expire_staticpage(staticpage)
  end

  private

  def expire_staticpage(staticpage)
    expire_page(:controller => "/staticpages", :action => "show", :page_url => staticpage.page_url)
  end
end

