class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_root_categories

  private
  def get_root_categories
    @root_categories ||= Category.roots
  end
end

