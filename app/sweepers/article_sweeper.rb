class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article

  def after_update(article)
    expire_article(article)
  end

  def after_destroy(article)
    expire_article(article)
  end

  private

  def expire_article(article)
    expire_action(:controller => "/articles", :action => "show", :id => article)
  end
end

