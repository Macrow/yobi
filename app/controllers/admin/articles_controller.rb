class Admin::ArticlesController < Admin::ApplicationController
  # GET /admin/articles
  # GET /admin/articles.json
  def index
    @articles = Article.order("created_at DESC").includes(:user).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @article }
    end
  end

  # GET /admin/articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @article = current_user.articles.build(params[:article])
    respond_to do |format|
      if @article.save
        format.html { redirect_to [:admin, @article], :notice => 'Article was successfully created.' }
        format.json { render :json => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to [:admin, @article], :notice => 'Article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :ok }
    end
  end
end

