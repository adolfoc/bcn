class PoblamientoImportLocationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 5
  end

  # GET /poblamiento_import_locations
  # GET /poblamiento_import_locations.json
  def index
    @poblamiento_import_locations = PoblamientoImportLocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poblamiento_import_locations }
    end
  end

  # GET /poblamiento_import_locations/1
  # GET /poblamiento_import_locations/1.json
  def show
    @poblamiento_import_location = PoblamientoImportLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poblamiento_import_location }
    end
  end

  # GET /poblamiento_import_locations/new
  # GET /poblamiento_import_locations/new.json
  def new
    @poblamiento_import_location = PoblamientoImportLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poblamiento_import_location }
    end
  end

  # GET /poblamiento_import_locations/1/edit
  def edit
    @poblamiento_import_location = PoblamientoImportLocation.find(params[:id])
  end

  # POST /poblamiento_import_locations
  # POST /poblamiento_import_locations.json
  def create
    @poblamiento_import_location = PoblamientoImportLocation.new(params[:poblamiento_import_location])

    respond_to do |format|
      if @poblamiento_import_location.save
        format.html { redirect_to @poblamiento_import_location, notice: 'Poblamiento import location was successfully created.' }
        format.json { render json: @poblamiento_import_location, status: :created, location: @poblamiento_import_location }
      else
        format.html { render action: "new" }
        format.json { render json: @poblamiento_import_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /poblamiento_import_locations/1
  # PUT /poblamiento_import_locations/1.json
  def update
    @poblamiento_import_location = PoblamientoImportLocation.find(params[:id])

    respond_to do |format|
      if @poblamiento_import_location.update_attributes(params[:poblamiento_import_location])
        format.html { redirect_to @poblamiento_import_location, notice: 'Poblamiento import location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @poblamiento_import_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poblamiento_import_locations/1
  # DELETE /poblamiento_import_locations/1.json
  def destroy
    @poblamiento_import_location = PoblamientoImportLocation.find(params[:id])
    @poblamiento_import_location.destroy

    respond_to do |format|
      format.html { redirect_to poblamiento_import_locations_url }
      format.json { head :ok }
    end
  end
end
