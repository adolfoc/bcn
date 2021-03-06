class TaskTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /task_types
  # GET /task_types.json
  def index
    screen_name("Admin-Indice-Tipos-Tarea")
    @task_types = TaskType.order("name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_types }
    end
  end

  # GET /task_types/1
  # GET /task_types/1.json
  def show
    screen_name("Admin-Mostrar-Tipo-Tarea")
    @task_type = TaskType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_type }
    end
  end

  # GET /task_types/new
  # GET /task_types/new.json
  def new
    screen_name("Admin-Nuevo-Tipo-Tarea")
    @task_type = TaskType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_type }
    end
  end

  # GET /task_types/1/edit
  def edit
    screen_name("Admin-Editar-Tipo-Tarea")
    @task_type = TaskType.find(params[:id])
  end

  # POST /task_types
  # POST /task_types.json
  def create
    @task_type = TaskType.new(params[:task_type])

    respond_to do |format|
      if @task_type.save
        format.html { redirect_to @task_type, notice: 'Task type was successfully created.' }
        format.json { render json: @task_type, status: :created, location: @task_type }
      else
        format.html { render action: "new" }
        format.json { render json: @task_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_types/1
  # PUT /task_types/1.json
  def update
    @task_type = TaskType.find(params[:id])

    respond_to do |format|
      if @task_type.update_attributes(params[:task_type])
        format.html { redirect_to @task_type, notice: 'Task type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_types/1
  # DELETE /task_types/1.json
  def destroy
    @task_type = TaskType.find(params[:id])
    @task_type.destroy

    respond_to do |format|
      format.html { redirect_to task_types_url }
      format.json { head :ok }
    end
  end
end
