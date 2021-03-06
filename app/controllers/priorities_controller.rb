class PrioritiesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /priorities
  # GET /priorities.json
  def index
    screen_name("Admin-Indice-Prioridades")
    @priorities = Priority.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @priorities }
    end
  end

  # GET /priorities/1
  # GET /priorities/1.json
  def show
    screen_name("Admin-Mostrar-Prioridad")
    @priority = Priority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @priority }
    end
  end

  # GET /priorities/new
  # GET /priorities/new.json
  def new
    screen_name("Admin-Nueva-Prioridad")
    @priority = Priority.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @priority }
    end
  end

  # GET /priorities/1/edit
  def edit
    screen_name("Admin-Editar-Prioridad")
    @priority = Priority.find(params[:id])
  end

  # POST /priorities
  # POST /priorities.json
  def create
    @priority = Priority.new(params[:priority])

    respond_to do |format|
      if @priority.save
        format.html { redirect_to @priority, notice: 'Priority was successfully created.' }
        format.json { render json: @priority, status: :created, location: @priority }
      else
        format.html { render action: "new" }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /priorities/1
  # PUT /priorities/1.json
  def update
    @priority = Priority.find(params[:id])

    respond_to do |format|
      if @priority.update_attributes(params[:priority])
        format.html { redirect_to @priority, notice: 'Priority was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /priorities/1
  # DELETE /priorities/1.json
  def destroy
    @priority = Priority.find(params[:id])
    @priority.destroy

    respond_to do |format|
      format.html { redirect_to priorities_url }
      format.json { head :ok }
    end
  end
end
