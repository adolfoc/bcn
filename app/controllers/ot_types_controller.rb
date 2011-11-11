class OtTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /ot_types
  # GET /ot_types.json
  def index
    screen_name("Admin-Indice-Tipos-OT")
    @ot_types = OtType.order("name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ot_types }
    end
  end

  # GET /ot_types/1
  # GET /ot_types/1.json
  def show
    screen_name("Admin-Mostrar-Tipo-OT")
    @ot_type = OtType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ot_type }
    end
  end

  # GET /ot_types/new
  # GET /ot_types/new.json
  def new
    screen_name("Admin-Nueva-Tipo-OT")
    @ot_type = OtType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ot_type }
    end
  end

  # GET /ot_types/1/edit
  def edit
    screen_name("Admin-Editar-Tipo-OT")
    @ot_type = OtType.find(params[:id])
  end

  # POST /ot_types
  # POST /ot_types.json
  def create
    @ot_type = OtType.new(params[:ot_type])

    respond_to do |format|
      if @ot_type.save
        format.html { redirect_to @ot_type, notice: 'Ot type was successfully created.' }
        format.json { render json: @ot_type, status: :created, location: @ot_type }
      else
        format.html { render action: "new" }
        format.json { render json: @ot_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ot_types/1
  # PUT /ot_types/1.json
  def update
    @ot_type = OtType.find(params[:id])

    respond_to do |format|
      if @ot_type.update_attributes(params[:ot_type])
        format.html { redirect_to @ot_type, notice: 'Ot type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ot_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ot_types/1
  # DELETE /ot_types/1.json
  def destroy
    @ot_type = OtType.find(params[:id])
    @ot_type.destroy

    respond_to do |format|
      format.html { redirect_to ot_types_url }
      format.json { head :ok }
    end
  end
end
