class BitacorasController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 7
  end

  # GET /bitacoras
  # GET /bitacoras.json
  def index
    @bitacoras = Bitacora.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bitacoras }
    end
  end

  # GET /bitacoras/1
  # GET /bitacoras/1.json
  def show
    @bitacora = Bitacora.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bitacora }
    end
  end

  # GET /bitacoras/new
  # GET /bitacoras/new.json
  def new
    @bitacora = Bitacora.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bitacora }
    end
  end

  # GET /bitacoras/1/edit
  def edit
    @bitacora = Bitacora.find(params[:id])
  end

  # POST /bitacoras
  # POST /bitacoras.json
  def create
    @bitacora = Bitacora.new(params[:bitacora])

    respond_to do |format|
      if @bitacora.save
        format.html { redirect_to @bitacora, notice: 'Bitacora was successfully created.' }
        format.json { render json: @bitacora, status: :created, location: @bitacora }
      else
        format.html { render action: "new" }
        format.json { render json: @bitacora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bitacoras/1
  # PUT /bitacoras/1.json
  def update
    @bitacora = Bitacora.find(params[:id])

    respond_to do |format|
      if @bitacora.update_attributes(params[:bitacora])
        format.html { redirect_to @bitacora, notice: 'Bitacora was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bitacora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bitacoras/1
  # DELETE /bitacoras/1.json
  def destroy
    @bitacora = Bitacora.find(params[:id])
    @bitacora.destroy

    respond_to do |format|
      format.html { redirect_to bitacoras_url }
      format.json { head :ok }
    end
  end
end
