class Admin::ImagesController < ApplicationController
  # GET /admin/images
  # GET /admin/images.json
  def index
    @images = Admin::Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @images }
    end
  end

  # GET /admin/images/1
  # GET /admin/images/1.json
  def show
    @image = Admin::Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @image }
    end
  end

  # GET /admin/images/new
  # GET /admin/images/new.json
  def new
    @image = Admin::Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @image }
    end
  end

  # GET /admin/images/1/edit
  def edit
    @image = Admin::Image.find(params[:id])
  end

  # POST /admin/images
  # POST /admin/images.json
  def create
    @product = Product.find(params[:product_id])
    @image = @product.images.build(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, :notice => 'Image was successfully created.' }
        format.json { render :json => @image, :status => :created, :location => @image }
        format.js
      else
        format.html { render :action => "new" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/images/1
  # PUT /admin/images/1.json
  def update
    @image = Admin::Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, :notice => 'Image was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/images/1
  # DELETE /admin/images/1.json
  def destroy
    @product = Product.find(params[:product_id])
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @product] }
      format.json { head :ok }
      format.js
    end
  end
end

