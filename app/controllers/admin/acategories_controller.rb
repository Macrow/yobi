# coding: utf-8
class Admin::AcategoriesController < Admin::ApplicationController

  # GET /admin/acategories
  # GET /admin/acategories.json
  def index
    @acategories = Acategory.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @categories }
    end
  end

  # GET /admin/acategories/1
  # GET /admin/acategories/1.json
  def show
    @acategory = Acategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @acategory }
    end
  end

  # GET /admin/acategories/new
  # GET /admin/acategories/new.json
  def new
    @acategory = Acategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @acategory }
    end
  end

  # GET /admin/acategories/1/edit
  def edit
    @acategory = Acategory.find(params[:id])
  end

  # POST /admin/acategories
  # POST /admin/acategories.json
  def create
    @acategory = Acategory.new(params[:acategory])

    respond_to do |format|
      if @acategory.save
        format.html { redirect_to [:admin,@acategory], :notice => 'Category was successfully created.' }
        format.json { render :json => @acategory, :status => :created, :location => @acategory }
      else
        format.html { render :action => "new" }
        format.json { render :json => @acategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/acategories/1
  # PUT /admin/acategories/1.json
  def update
    @acategory = Acategory.find(params[:id])

    respond_to do |format|
      if @acategory.update_attributes(params[:acategory])
        format.html { redirect_to [:admin,@acategory], :notice => 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @acategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/acategories/1
  # DELETE /admin/acategories/1.json
  def destroy
    @acategory = Acategory.find(params[:id])
    @acategory.destroy

    respond_to do |format|
      format.html { redirect_to admin_acategories_url }
      format.json { head :ok }
    end
  end

end

