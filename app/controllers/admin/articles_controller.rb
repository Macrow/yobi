# coding: utf-8

class Admin::ArticlesController < Admin::ApplicationController
  cache_sweeper :article_sweeper, :only => [:update, :destroy]

  def index
    @articles = Article.order("created_at DESC").includes(:user).page(params[:page]).per(10)
    respond_to do |format|
      format.html
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.build(params[:article])
    respond_to do |format|
      if @article.save
        format.html { redirect_to [:admin, @article], :notice => "已添加 #{@article.title}！" }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to [:admin, @article], :notice => "已更新 #{@article.title}！" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
    end
  end
end

