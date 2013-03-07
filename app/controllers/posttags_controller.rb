class PosttagsController < ApplicationController
  # GET /posttags
  # GET /posttags.json
  def index
    @posttags = Posttag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posttags }
    end
  end

  # GET /posttags/1
  # GET /posttags/1.json
  def show
    @posttag = Posttag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @posttag }
    end
  end

  # GET /posttags/new
  # GET /posttags/new.json
  def new
    @posttag = Posttag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @posttag }
    end
  end

  # GET /posttags/1/edit
  def edit
    @posttag = Posttag.find(params[:id])
  end

  # POST /posttags
  # POST /posttags.json
  def create
    @posttag = Posttag.new(params[:posttag])

    respond_to do |format|
      if @posttag.save
        format.html { redirect_to @posttag, notice: 'Posttag was successfully created.' }
        format.json { render json: @posttag, status: :created, location: @posttag }
      else
        format.html { render action: "new" }
        format.json { render json: @posttag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posttags/1
  # PUT /posttags/1.json
  def update
    @posttag = Posttag.find(params[:id])

    respond_to do |format|
      if @posttag.update_attributes(params[:posttag])
        format.html { redirect_to @posttag, notice: 'Posttag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @posttag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posttags/1
  # DELETE /posttags/1.json
  def destroy
    @posttag = Posttag.find(params[:id])
    @posttag.destroy

    respond_to do |format|
      format.html { redirect_to posttags_url }
      format.json { head :no_content }
    end
  end
end
