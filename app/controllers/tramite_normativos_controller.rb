class TramiteNormativosController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 7
  end

  # GET /tramite_normativos
  # GET /tramite_normativos.json
  def index
    @tramite_normativos = TramiteNormativo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tramite_normativos }
    end
  end

  # GET /tramite_normativos/1
  # GET /tramite_normativos/1.json
  def show
    @tramite_normativo = TramiteNormativo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tramite_normativo }
    end
  end

  # GET /tramite_normativos/new
  # GET /tramite_normativos/new.json
  def new
    @tramite_normativo = TramiteNormativo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tramite_normativo }
    end
  end

  # GET /tramite_normativos/1/edit
  def edit
    @tramite_normativo = TramiteNormativo.find(params[:id])
  end

  # POST /tramite_normativos
  # POST /tramite_normativos.json
  def create
    @tramite_normativo = TramiteNormativo.new(params[:tramite_normativo])

    respond_to do |format|
      if @tramite_normativo.save
        format.html { redirect_to @tramite_normativo, notice: 'Tramite normativo was successfully created.' }
        format.json { render json: @tramite_normativo, status: :created, location: @tramite_normativo }
      else
        format.html { render action: "new" }
        format.json { render json: @tramite_normativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tramite_normativos/1
  # PUT /tramite_normativos/1.json
  def update
    @tramite_normativo = TramiteNormativo.find(params[:id])

    respond_to do |format|
      if @tramite_normativo.update_attributes(params[:tramite_normativo])
        format.html { redirect_to @tramite_normativo, notice: 'Tramite normativo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tramite_normativo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tramite_normativos/1
  # DELETE /tramite_normativos/1.json
  def destroy
    @tramite_normativo = TramiteNormativo.find(params[:id])
    @tramite_normativo.destroy

    respond_to do |format|
      format.html { redirect_to tramite_normativos_url }
      format.json { head :ok }
    end
  end
end
