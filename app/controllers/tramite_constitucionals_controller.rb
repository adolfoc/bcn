class TramiteConstitucionalsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 7
  end

  # GET /tramite_constitucionals
  # GET /tramite_constitucionals.json
  def index
    @tramite_constitucionals = TramiteConstitucional.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tramite_constitucionals }
    end
  end

  # GET /tramite_constitucionals/1
  # GET /tramite_constitucionals/1.json
  def show
    @tramite_constitucional = TramiteConstitucional.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tramite_constitucional }
    end
  end

  # GET /tramite_constitucionals/new
  # GET /tramite_constitucionals/new.json
  def new
    @tramite_constitucional = TramiteConstitucional.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tramite_constitucional }
    end
  end

  # GET /tramite_constitucionals/1/edit
  def edit
    @tramite_constitucional = TramiteConstitucional.find(params[:id])
  end

  # POST /tramite_constitucionals
  # POST /tramite_constitucionals.json
  def create
    @tramite_constitucional = TramiteConstitucional.new(params[:tramite_constitucional])

    respond_to do |format|
      if @tramite_constitucional.save
        format.html { redirect_to @tramite_constitucional, notice: 'Tramite constitucional was successfully created.' }
        format.json { render json: @tramite_constitucional, status: :created, location: @tramite_constitucional }
      else
        format.html { render action: "new" }
        format.json { render json: @tramite_constitucional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tramite_constitucionals/1
  # PUT /tramite_constitucionals/1.json
  def update
    @tramite_constitucional = TramiteConstitucional.find(params[:id])

    respond_to do |format|
      if @tramite_constitucional.update_attributes(params[:tramite_constitucional])
        format.html { redirect_to @tramite_constitucional, notice: 'Tramite constitucional was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tramite_constitucional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tramite_constitucionals/1
  # DELETE /tramite_constitucionals/1.json
  def destroy
    @tramite_constitucional = TramiteConstitucional.find(params[:id])
    @tramite_constitucional.destroy

    respond_to do |format|
      format.html { redirect_to tramite_constitucionals_url }
      format.json { head :ok }
    end
  end
end
