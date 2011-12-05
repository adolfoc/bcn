class PlanCorreccionController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 0
  end

  ##########################################################
  # Controller interface: States
  ##########################################################

  def perform_work
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @ot.mark_read

    case @task.workflow_state
    when "eligiendo_documento"
      eligiendo_documento
    when "asignando_tareas"
      asignando_tareas
    when "notificar_analista"
      notificar_analista
    end
  end

  def eligiendo_documento
    screen_name("#{@task.class.to_s}/eligiendo_documento")

    respond_to do |format|
      format.html { render action: "eligiendo_documento" }
      format.json { head :ok }
    end
  end

  # POST create_eligiendo_documento
  def create_eligiendo_documento
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)
    @frbr_work = FrbrWork.find(params[:frbr_work_id])

    respond_to do |format|
      # Associate ot to new manifestation
      @ot.assign_source(@frbr_work.frbr_expressions[0].frbr_manifestations[0])
      @ot.assign_target(@frbr_work.frbr_expressions[1].frbr_manifestations[0])

      # Move on
      do_perform_transition(:documentos_elegidos)

      format.html { 
        @tasks = []
        @ot.tasks.each do |task|
          @tasks << task if task.id != @task.id
        end
        render "asignando_tareas", notice: 'El documento Frbr fue elegido sin problemas.' 
      }
    end
  end

  def asignando_tareas
    screen_name("#{@task.class.to_s}/asignando_tareas")

    @tasks = []
    @ot.tasks.each do |task|
      @tasks << task if task.id != @task.id
    end

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end

  # POST create_asignando_tareas
  def create_asignando_tareas
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    params[:tarea].each_pair do |key, value|
      if key != @task.id
        this_task = Task.find(key)
        this_task.current_user_id = value
        this_task.save
      end
    end

    do_perform_transition(:tareas_asignadas)

    respond_to do |format|
      format.html { 
        render "notificar_analista", notice: 'Las tareas fueron asignadas sin dificultades.' 
      }
      format.json { head :ok }
    end
  end

  def notificar_analista
    screen_name("#{@task.class.to_s}/notificar_analista")

    respond_to do |format|
      format.html { render action: "notificar_analista" }
      format.json { head :ok }
    end
  end

  # POST create_notificar_analista
  def create_notificar_analista
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    # Call next workflow
    next_task = @task.successor
    call_next_workflow(next_task)

    # Make first transition
    @task = next_task
    do_perform_transition(:asignacion)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'El analista fue notificado.' }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def documentos_elegidos_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:documentos_elegidos)

    @tasks = []
    @ot.tasks.each do |task|
      @tasks << task if task.id != @task.id
    end

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end

  def tareas_asignadas_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:tareas_asignadas)

    respond_to do |format|
      format.html { render action: "notificar_analista" }
      format.json { head :ok }
    end
  end
end
