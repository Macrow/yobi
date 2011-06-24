class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_categories

  private
  def get_categories
    @categories ||= Category.arrange(:order => :created_at)
  end
end

