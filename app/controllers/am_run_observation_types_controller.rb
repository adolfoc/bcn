class AmRunObservationTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /am_run_observation_types
  # GET /am_run_observation_types.json
  def index
    @am_run_observation_types = AmRunObservationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @am_run_observation_types }
    end
  end

  # GET /am_run_observation_types/1
  # GET /am_run_observation_types/1.json
  def show
    @am_run_observation_type = AmRunObservationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @am_run_observation_type }
    end
  end

  # GET /am_run_observation_types/new
  # GET /am_run_observation_types/new.json
  def new
    @am_run_observation_type = AmRunObservationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @am_run_observation_type }
    end
  end

  # GET /am_run_observation_types/1/edit
  def edit
    @am_run_observation_type = AmRunObservationType.find(params[:id])
  end

  # POST /am_run_observation_types
  # POST /am_run_observation_types.json
  def create
    @am_run_observation_type = AmRunObservationType.new(params[:am_run_observation_type])

    respond_to do |format|
      if @am_run_observation_type.save
        format.html { redirect_to @am_run_observation_type, notice: 'Am run observation type was successfully created.' }
        format.json { render json: @am_run_observation_type, status: :created, location: @am_run_observation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @am_run_observation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /am_run_observation_types/1
  # PUT /am_run_observation_types/1.json
  def update
    @am_run_observation_type = AmRunObservationType.find(params[:id])

    respond_to do |format|
      if @am_run_observation_type.update_attributes(params[:am_run_observation_type])
        format.html { redirect_to @am_run_observation_type, notice: 'Am run observation type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @am_run_observation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /am_run_observation_types/1
  # DELETE /am_run_observation_types/1.json
  def destroy
    @am_run_observation_type = AmRunObservationType.find(params[:id])
    @am_run_observation_type.destroy

    respond_to do |format|
      format.html { redirect_to am_run_observation_types_url }
      format.json { head :ok }
    end
  end
end
