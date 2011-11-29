class AmObservationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /am_observations
  # GET /am_observations.json
  def index
    @am_observations = AmObservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @am_observations }
    end
  end

  # GET /am_observations/1
  # GET /am_observations/1.json
  def show
    @am_observation = AmObservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @am_observation }
    end
  end

  # GET /am_observations/new
  # GET /am_observations/new.json
  def new
    @am_observation = AmObservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @am_observation }
    end
  end

  # GET /am_observations/1/edit
  def edit
    @am_observation = AmObservation.find(params[:id])
  end

  # POST /am_observations
  # POST /am_observations.json
  def create
    @am_observation = AmObservation.new(params[:am_observation])

    respond_to do |format|
      if @am_observation.save
        format.html { redirect_to @am_observation, notice: 'Am observation was successfully created.' }
        format.json { render json: @am_observation, status: :created, location: @am_observation }
      else
        format.html { render action: "new" }
        format.json { render json: @am_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /am_observations/1
  # PUT /am_observations/1.json
  def update
    @am_observation = AmObservation.find(params[:id])

    respond_to do |format|
      if @am_observation.update_attributes(params[:am_observation])
        format.html { redirect_to @am_observation, notice: 'Am observation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @am_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /am_observations/1
  # DELETE /am_observations/1.json
  def destroy
    @am_observation = AmObservation.find(params[:id])
    @am_observation.destroy

    respond_to do |format|
      format.html { redirect_to am_observations_url }
      format.json { head :ok }
    end
  end
end
