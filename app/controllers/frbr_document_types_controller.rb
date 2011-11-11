class FrbrDocumentTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /frbr_document_types
  # GET /frbr_document_types.json
  def index
    screen_name("Admin-Indice-Tipos-Documento-FRBR")
    @frbr_document_types = FrbrDocumentType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_document_types }
    end
  end

  # GET /frbr_document_types/1
  # GET /frbr_document_types/1.json
  def show
    screen_name("Admin-Mostrar-Tipo-Documento-FRBR")
    @frbr_document_type = FrbrDocumentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_document_type }
    end
  end

  # GET /frbr_document_types/new
  # GET /frbr_document_types/new.json
  def new
    screen_name("Admin-Nuevo-Tipo-Documento-FRBR")
    @frbr_document_type = FrbrDocumentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_document_type }
    end
  end

  # GET /frbr_document_types/1/edit
  def edit
    screen_name("Admin-Editar-Tipo-Documento-FRBR")
    @frbr_document_type = FrbrDocumentType.find(params[:id])
  end

  # POST /frbr_document_types
  # POST /frbr_document_types.json
  def create
    @frbr_document_type = FrbrDocumentType.new(params[:frbr_document_type])

    respond_to do |format|
      if @frbr_document_type.save
        format.html { redirect_to @frbr_document_type, notice: 'Frbr document type was successfully created.' }
        format.json { render json: @frbr_document_type, status: :created, location: @frbr_document_type }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_document_types/1
  # PUT /frbr_document_types/1.json
  def update
    @frbr_document_type = FrbrDocumentType.find(params[:id])

    respond_to do |format|
      if @frbr_document_type.update_attributes(params[:frbr_document_type])
        format.html { redirect_to @frbr_document_type, notice: 'Frbr document type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_document_types/1
  # DELETE /frbr_document_types/1.json
  def destroy
    @frbr_document_type = FrbrDocumentType.find(params[:id])
    @frbr_document_type.destroy

    respond_to do |format|
      format.html { redirect_to frbr_document_types_url }
      format.json { head :ok }
    end
  end
end
