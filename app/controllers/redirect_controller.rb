class RedirectController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => 404 }
      format.all { render :nothing => true, :status => 404 }
    end
  end
end

