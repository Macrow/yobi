# coding: utf-8

class Admin::PlistsController < Admin::ApplicationController

  def index
    @plists = Plist.all
  end

  def edit
    @plist = Plist.find(params[:id])
  end

  def create
    @plist = Plist.new(params[:plist])
    respond_to do |format|
      if @plist.save
        format.html { redirect_to admin_plists_url, :notice => '添加成功！' }
        format.js
      end
    end
  end


  def update
    @plist = Plist.find(params[:id])
    respond_to do |format|
      if @plist.update_attributes(params[:plist])
        format.html { redirect_to admin_plists_url, :notice => '更新成功！' }
        format.js
      end
    end
  end

  def destroy
    @plist = Plist.find(params[:id])
    @plist.destroy
    respond_to do |format|
      format.html { redirect_to admin_plists_url }
    end
  end
end

