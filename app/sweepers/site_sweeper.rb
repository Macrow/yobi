class SiteSweeper < ActionController::Caching::Sweeper
  observe Menu

  def after_save(record)
    self.class::sweep
  end
  
  def after_destroy(record)
    self.class::sweep
  end
  
  def self.sweep
    cache_dir = "#{Rails.root}/tmp/cache"
    unless cache_dir == RAILS_ROOT + "/public"
      FileUtils.rm_r(Dir.glob(cache_dir+"/*")) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache directory '#{cache_dir}' fully swept.")
    end
  end
end