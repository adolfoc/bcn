class FrbrManifestationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /frbr_manifestations
  # GET /frbr_manifestations.json
  def index
    screen_name("Admin-Indice-Manifestaciones-FRBR")
    @frbr_manifestations = FrbrManifestation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_manifestations }
    end
  end

  # GET /frbr_manifestations/1
  # GET /frbr_manifestations/1.json
  def show
    screen_name("Admin-Mostrar-Manifestacion-FRBR")
    @frbr_manifestation = FrbrManifestation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_manifestation }
    end
  end

  # GET /frbr_manifestations/new
  # GET /frbr_manifestations/new.json
  def new
    screen_name("Admin-Nuevo-Manifestacion-FRBR")
    @frbr_manifestation = FrbrManifestation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_manifestation }
    end
  end

  # GET /frbr_manifestations/1/edit
  def edit
    screen_name("Admin-Editar-Manifestacion-FRBR")
    @frbr_manifestation = FrbrManifestation.find(params[:id])
  end

  # POST /frbr_manifestations
  # POST /frbr_manifestations.json
  def create
    @frbr_manifestation = FrbrManifestation.new(params[:frbr_manifestation])

    respond_to do |format|
      if @frbr_manifestation.save
        format.html { redirect_to @frbr_manifestation, notice: 'Frbr manifestation was successfully created.' }
        format.json { render json: @frbr_manifestation, status: :created, location: @frbr_manifestation }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_manifestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_manifestations/1
  # PUT /frbr_manifestations/1.json
  def update
    @frbr_manifestation = FrbrManifestation.find(params[:id])

    respond_to do |format|
      if @frbr_manifestation.update_attributes(params[:frbr_manifestation])
        format.html { redirect_to @frbr_manifestation, notice: 'Frbr manifestation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_manifestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_manifestations/1
  # DELETE /frbr_manifestations/1.json
  def destroy
    @frbr_manifestation = FrbrManifestation.find(params[:id])
    @frbr_manifestation.destroy

    respond_to do |format|
      format.html { redirect_to frbr_manifestations_url }
      format.json { head :ok }
    end
  end
end
