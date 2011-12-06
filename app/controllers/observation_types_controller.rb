class ObservationTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /observation_types
  # GET /observation_types.json
  def index
    @observation_types = ObservationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @observation_types }
    end
  end

  # GET /observation_types/1
  # GET /observation_types/1.json
  def show
    @observation_type = ObservationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @observation_type }
    end
  end

  # GET /observation_types/new
  # GET /observation_types/new.json
  def new
    @observation_type = ObservationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observation_type }
    end
  end

  # GET /observation_types/1/edit
  def edit
    @observation_type = ObservationType.find(params[:id])
  end

  # POST /observation_types
  # POST /observation_types.json
  def create
    @observation_type = ObservationType.new(params[:observation_type])

    respond_to do |format|
      if @observation_type.save
        format.html { redirect_to @observation_type, notice: 'Observation type was successfully created.' }
        format.json { render json: @observation_type, status: :created, location: @observation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @observation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /observation_types/1
  # PUT /observation_types/1.json
  def update
    @observation_type = ObservationType.find(params[:id])

    respond_to do |format|
      if @observation_type.update_attributes(params[:observation_type])
        format.html { redirect_to @observation_type, notice: 'Observation type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @observation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observation_types/1
  # DELETE /observation_types/1.json
  def destroy
    @observation_type = ObservationType.find(params[:id])
    @observation_type.destroy

    respond_to do |format|
      format.html { redirect_to observation_types_url }
      format.json { head :ok }
    end
  end
end
