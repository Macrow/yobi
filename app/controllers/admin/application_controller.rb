class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_admin!

  private

  def authenticate_admin!
    unless (authenticate_user! && current_user.admin?)
      redirect_to root_path, :notice => "administrator only!"
    end
  end
end

