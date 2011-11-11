class FrbrWorksController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /frbr_works
  # GET /frbr_works.json
  def index
    screen_name("Admin-Indice-Obras-FRBR")
    @frbr_works = FrbrWork.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_works }
    end
  end

  # GET /frbr_works/1
  # GET /frbr_works/1.json
  def show
    screen_name("Admin-Mostrar-Obra-FRBR")
    @frbr_work = FrbrWork.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_work }
    end
  end

  # GET /frbr_works/new
  # GET /frbr_works/new.json
  def new
    screen_name("Admin-Nueva-Obra-FRBR")
    @frbr_work = FrbrWork.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_work }
    end
  end

  # GET /frbr_works/1/edit
  def edit
    screen_name("Admin-Editar-Obra-FRBR")
    @frbr_work = FrbrWork.find(params[:id])
  end

  # POST /frbr_works
  # POST /frbr_works.json
  def create
    @frbr_work = FrbrWork.new(params[:frbr_work])

    respond_to do |format|
      if @frbr_work.save
        format.html { redirect_to @frbr_work, notice: 'Frbr work was successfully created.' }
        format.json { render json: @frbr_work, status: :created, location: @frbr_work }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_works/1
  # PUT /frbr_works/1.json
  def update
    @frbr_work = FrbrWork.find(params[:id])

    respond_to do |format|
      if @frbr_work.update_attributes(params[:frbr_work])
        format.html { redirect_to @frbr_work, notice: 'Frbr work was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_works/1
  # DELETE /frbr_works/1.json
  def destroy
    @frbr_work = FrbrWork.find(params[:id])
    @frbr_work.destroy

    respond_to do |format|
      format.html { redirect_to frbr_works_url }
      format.json { head :ok }
    end
  end
end
