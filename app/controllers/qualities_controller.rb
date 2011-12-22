class QualitiesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /qualities
  # GET /qualities.json
  def index
    @qualities = Quality.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qualities }
    end
  end

  # GET /qualities/1
  # GET /qualities/1.json
  def show
    @quality = Quality.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quality }
    end
  end

  # GET /qualities/new
  # GET /qualities/new.json
  def new
    @quality = Quality.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quality }
    end
  end

  # GET /qualities/1/edit
  def edit
    @quality = Quality.find(params[:id])
  end

  # POST /qualities
  # POST /qualities.json
  def create
    @quality = Quality.new(params[:quality])

    respond_to do |format|
      if @quality.save
        format.html { redirect_to @quality, notice: 'Quality was successfully created.' }
        format.json { render json: @quality, status: :created, location: @quality }
      else
        format.html { render action: "new" }
        format.json { render json: @quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /qualities/1
  # PUT /qualities/1.json
  def update
    @quality = Quality.find(params[:id])

    respond_to do |format|
      if @quality.update_attributes(params[:quality])
        format.html { redirect_to @quality, notice: 'Quality was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @quality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qualities/1
  # DELETE /qualities/1.json
  def destroy
    @quality = Quality.find(params[:id])
    @quality.destroy

    respond_to do |format|
      format.html { redirect_to qualities_url }
      format.json { head :ok }
    end
  end
end
