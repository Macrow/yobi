class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.order("created_at DESC").page(params[:page]).per(10)
  end

  def admins
    @users = User.order("created_at DESC").where(:admin => true).page(params[:page]).per(10)
    render :action => :index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to [:admin, @user], :notice => "已成功更新 #{@user.user_name} 信息！"
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to [:admin, :users], :notice => "已成功删除 #{@user.user_name}！"
  end
end

