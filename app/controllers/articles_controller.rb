class ArticlesController < ApplicationController
  caches_action :show
  def show
    @article = Article.find(params[:id])
    @acategory = @article.acategory
  end
end
