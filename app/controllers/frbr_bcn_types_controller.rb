class FrbrBcnTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /frbr_bcn_types
  # GET /frbr_bcn_types.json
  def index
    screen_name("Admin-Indice-Tipos-FRBR-BCN")
    @frbr_bcn_types = FrbrBcnType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_bcn_types }
    end
  end

  # GET /frbr_bcn_types/1
  # GET /frbr_bcn_types/1.json
  def show
    screen_name("Admin-Mostrar-Tipo-FRBR-BCN")
    @frbr_bcn_type = FrbrBcnType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_bcn_type }
    end
  end

  # GET /frbr_bcn_types/new
  # GET /frbr_bcn_types/new.json
  def new
    screen_name("Admin-Nuevo-Tipo-FRBR-BCN")
    @frbr_bcn_type = FrbrBcnType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_bcn_type }
    end
  end

  # GET /frbr_bcn_types/1/edit
  def edit
    screen_name("Admin-Editar-Tipo-FRBR-BCN")
    @frbr_bcn_type = FrbrBcnType.find(params[:id])
  end

  # POST /frbr_bcn_types
  # POST /frbr_bcn_types.json
  def create
    @frbr_bcn_type = FrbrBcnType.new(params[:frbr_bcn_type])

    respond_to do |format|
      if @frbr_bcn_type.save
        format.html { redirect_to @frbr_bcn_type, notice: 'Frbr bcn type was successfully created.' }
        format.json { render json: @frbr_bcn_type, status: :created, location: @frbr_bcn_type }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_bcn_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_bcn_types/1
  # PUT /frbr_bcn_types/1.json
  def update
    @frbr_bcn_type = FrbrBcnType.find(params[:id])

    respond_to do |format|
      if @frbr_bcn_type.update_attributes(params[:frbr_bcn_type])
        format.html { redirect_to @frbr_bcn_type, notice: 'Frbr bcn type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_bcn_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_bcn_types/1
  # DELETE /frbr_bcn_types/1.json
  def destroy
    @frbr_bcn_type = FrbrBcnType.find(params[:id])
    @frbr_bcn_type.destroy

    respond_to do |format|
      format.html { redirect_to frbr_bcn_types_url }
      format.json { head :ok }
    end
  end
end
