class Admin::DimagesController < Admin::ApplicationController

  def index
    @dimages = Dimage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @dimages }
    end
  end

  def create
    @dimage = Dimage.new(params[:dimage])
    respond_to do |format|
      if @dimage.save
        format.html { redirect_to @dimage, :notice => 'Dimage was successfully created.' }
        format.json { render :json => @dimage, :status => :created, :location => @dimage }
        format.js
      else
        format.html { render :action => "new" }
        format.json { render :json => @dimage.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @dimage = Dimage.find(params[:id])
    @dimage.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @product] }
      format.json { head :ok }
      format.js
    end
  end
end

