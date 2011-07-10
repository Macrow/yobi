class StaticpagesController < ApplicationController
  caches_page :show
  def show
    @staticpage = Staticpage.find_by_page_url(params[:page_url])
    raise ActiveRecord::RecordNotFound if @staticpage.nil?
  end
end