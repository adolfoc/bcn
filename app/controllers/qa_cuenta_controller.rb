require 'workflow_controller'

class QaCuentaController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  def perform_work
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @event = params[:event]

    case @task.workflow_state
    when "esperando_notificacion_analista"
      esperando_notificacion_analista
    when "por_validar_qa"
      por_validar_qa
    when "evalua_qa"
      evalua_qa
    when "devuelve_a_analista"
      devuelve_a_analista
    when "devuelve_a_planificador"
      devuelve_a_planificador
    when "guarda_documento"
      guarda_documento
    end
  end

  # Actions that bring back a state
  def esperando_notificacion_analista
    screen_name("#{@task.class.to_s}/esperando_notificacion_analista")

    respond_to do |format|
      format.html { render action: "esperando_notificacion_analista" }
      format.json { head :ok }
    end
  end

  def por_validar_qa
    screen_name("#{@task.class.to_s}/por_validar_qa")

    respond_to do |format|
      format.html { render action: "por_validar_qa" }
      format.json { head :ok }
    end
  end

  def evalua_qa
    screen_name("#{@task.class.to_s}/evalua_qa")

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  def devuelve_a_analista
    screen_name("#{@task.class.to_s}/devuelve_a_analista")

    respond_to do |format|
      format.html { render action: "devuelve_a_analista" }
      format.json { head :ok }
    end
  end

  def devuelve_a_planificador
    screen_name("#{@task.class.to_s}/devuelve_a_planificador")

    respond_to do |format|
      format.html { render action: "devuelve_a_planificador" }
      format.json { head :ok }
    end
  end

  def guarda_documento
    screen_name("#{@task.class.to_s}/guarda_documento")

    respond_to do |format|
      format.html { render action: "guarda_documento" }
      format.json { head :ok }
    end
  end

  # Actions that trigger a change of state
  def do_perform_transition(event)
    @event = event
    perform_transition

    # Refresh task with new state
    @task = Task.find(params[:task_id])
  end

  def recibe_notificacion_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("recibe_notificacion")

    respond_to do |format|
      format.html { render action: "por_validar_qa" }
      format.json { head :ok }
    end
  end

  def comienza_validar_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("comienza_validar")

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  def rechaza_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    # Call next workflow
    next_task = @ot.tasks.select { |task| true if task.task_type_id == 1 }.first
    @ot.current_task_id = next_task.id
    @ot.current_step = next_task.initial_task.to_s
    @ot.save

    create_log_entry_for_workflow(@task.name, next_task.name)

    # Refresh task with new state
    @task = Task.find(params[:task_id])

    respond_to do |format|
      format.html { render action: "devuelve_a_analista" }
      format.json { head :ok }
    end
  end

  def aprueba_tarea_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("aprueba_tarea")

    respond_to do |format|
      format.html { render action: "devuelve_a_planificador" }
      format.json { head :ok }
    end
  end

  def aprueba_ot_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("aprueba_ot")
    @ot.mark_complete

    respond_to do |format|
      format.html { render action: "guarda_documento" }
      format.json { head :ok }
    end
  end
end
