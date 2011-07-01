class MenuSweeper < ActionController::Caching::Sweeper
  observe Category

  def after_create(category)
    expire_menu
  end

  def after_update(category)
    expire_menu
  end

  def after_destroy(category)
    expire_menu
  end

  private

  def expire_menu
    expire_fragment("navmenu")
  end
end

