require 'big_sitemap'

class Admin::SettingsController < Admin::ApplicationController
  def index
  end
  
  def generate_sitemap
    sitemap = BigSitemap.new(
      :url_options   => {:host => Settings.site.url},
      :document_root => "#{Rails.root}/public",
      :gzip => false,
      :document_path => ""
    )
    
    sitemap.add Article
    sitemap.add Product
    sitemap.add_static(Settings.site.url, Time.now, 'weekly', 1.0)

    sitemap.generate
    
    redirect_to admin_settings_path, :notice => "xml地图生成完毕！"
  end
end
