# coding: utf-8

class Admin::MenusController < Admin::ApplicationController
  
  cache_sweeper :home_sweeper, :only => [:create, :update, :destroy]
  cache_sweeper :site_sweeper, :only => [:create, :update, :destroy]

  def index
    @menus = Menu.scoped
    respond_to do |format|
      format.html
    end
  end

  def show
    @menu = Menu.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    if params[:category_id]
      category = Category.find(params[:category_id])
      @menu = Menu.new(:name => category.name, :url => category_path(category))
    else  
      @menu = Menu.new
    end
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def create
    @menu = Menu.new(params[:menu])
    respond_to do |format|
      if @menu.save
        format.html { redirect_to [:admin, @menu], :notice => "已添加 #{@menu.name}！" }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @menu = Menu.find(params[:id])
    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to [:admin, @menu], :notice => "已更新 #{@menu.name}！" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_url }
    end
  end
end

