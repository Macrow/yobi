class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_categories

  private
  def get_categories
    @categories ||= Category.arrange(:order => :created_at)
    @root_categories ||= @categories.keys
  end
end

