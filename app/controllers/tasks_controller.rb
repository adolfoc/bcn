class TasksController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /tasks
  # GET /tasks.json
  def index
    screen_name("Admin-Indice-Tareas")
    @tasks = Task.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    screen_name("Admin-Mostrar-Tarea")
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    screen_name("Admin-Nueva-Tarea")
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    screen_name("Admin-Editar-Tarea")
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    if params[:task][:task_type_id] == "1"
      @task = MarcadoCuentaTask.new(params[:task])
      @task.workflow_state = @task.initial_task
    elsif params[:task][:task_type_id] == "5"
      @task = QaCuentaTask.new(params[:task])
      @task.workflow_state = @task.initial_task
    elsif params[:task][:task_type_id] == "4"
      @task = PlanCuentaTask.new(params[:task])
      @task.workflow_state = @task.initial_task
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :ok }
    end
  end
end
