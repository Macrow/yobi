# coding: utf-8
class Admin::StaticpagesController < Admin::ApplicationController
  cache_sweeper :staticpage_sweeper, :only => [:update, :destroy]

  def index
    @staticpages = Staticpage.page(params[:page]).per(10)
    respond_to do |format|
      format.html
    end
  end

  def show
    @staticpage = Staticpage.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @staticpage = Staticpage.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @staticpage = Staticpage.find(params[:id])
  end

  def create
    @staticpage = Staticpage.new(params[:staticpage])
    respond_to do |format|
      if @staticpage.save
        format.html { redirect_to [:admin, @staticpage], :notice => "已添加 #{@staticpage.title}！" }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @staticpage = Staticpage.find(params[:id])
    respond_to do |format|
      if @staticpage.update_attributes(params[:staticpage])
        format.html { redirect_to [:admin, @staticpage], :notice => "已更新 #{@staticpage.title}！" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @staticpage = Staticpage.find(params[:id])
    @staticpage.destroy
    respond_to do |format|
      format.html { redirect_to admin_staticpages_url }
    end
  end
end