class AcategoriesController < ApplicationController
  def show
    @acategory = Acategory.find(params[:id])
    @articles = @acategory.articles
  end
end
