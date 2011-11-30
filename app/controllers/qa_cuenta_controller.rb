require 'workflow_controller'

class QaCuentaController < ApplicationController
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

    # Read it so we can display it
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

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
  def recibe_notificacion_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:recibe_notificacion)

    respond_to do |format|
      format.html { render action: "por_validar_qa" }
      format.json { head :ok }
    end
  end

  def comienza_validar_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:comienza_validar)

    # Read it so we can display it
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "evalua_qa" }
      format.json { head :ok }
    end
  end

  def rechaza_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:rechaza)

    # Call next workflow
    next_task = @task.predecessor
    call_next_workflow(next_task)
  
    # Make first transition
    @task = next_task
    do_perform_transition(:asignacion)

    respond_to do |format|
      format.html { render action: "devuelve_a_analista" }
      format.json { head :ok }
    end
  end

  def aprueba_tarea_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:aprueba_tarea)

    respond_to do |format|
      format.html { render action: "devuelve_a_planificador" }
      format.json { head :ok }
    end
  end

  def aprueba_ot_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:aprueba_ot)

    respond_to do |format|
      format.html { render action: "guarda_documento" }
      format.json { head :ok }
    end
  end

  def publica_documento_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:publica_documento)
    @task.mark_complete
    @ot.mark_complete

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :ok }
    end
  end
end
