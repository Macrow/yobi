class Admin::HomeController < Admin::ApplicationController
  def index
    @category_count = Category.count
    @product_count = Product.count
    @article_count = Article.count
    @comment_count = Comment.count
    @user_count = User.count
  end
end

