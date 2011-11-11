class ObservationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /observations
  # GET /observations.json
  def index
    screen_name("Admin-Indice-Observaciones")
    @observations = Observation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @observations }
    end
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
    screen_name("Admin-Mostrar-Observacion")
    @observation = Observation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @observation }
    end
  end

  # GET /observations/new
  # GET /observations/new.json
  def new
    screen_name("Admin-Nueva-Observacion")
    @observation = Observation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observation }
    end
  end

  # GET /observations/1/edit
  def edit
    screen_name("Admin-Editar-Observacion")
    @observation = Observation.find(params[:id])
  end

  # POST /observations
  # POST /observations.json
  def create
    @observation = Observation.new(params[:observation])

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: 'Observation was successfully created.' }
        format.json { render json: @observation, status: :created, location: @observation }
      else
        format.html { render action: "new" }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /observations/1
  # PUT /observations/1.json
  def update
    @observation = Observation.find(params[:id])

    respond_to do |format|
      if @observation.update_attributes(params[:observation])
        format.html { redirect_to @observation, notice: 'Observation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation = Observation.find(params[:id])
    @observation.destroy

    respond_to do |format|
      format.html { redirect_to observations_url }
      format.json { head :ok }
    end
  end
end
