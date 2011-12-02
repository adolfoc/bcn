class PlanDiarioPostController < ApplicationController
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
    when "esperando_notificacion_analista"
      esperando_notificacion_analista
    when "verificando_completitud"
      verificando_completitud
    when "revisando_documento_completo"
      revisando_documento_completo
    when "asignando_tareas"
      asignando_tareas
    when "publicando_diario_de_sesiones"
      publicando_diario_de_sesiones
    when "notificando_equipos"
      notificando_equipos
    end
  end

  def esperando_notificacion_analista
    screen_name("#{@task.class.to_s}/esperando_notificacion_analista")

    respond_to do |format|
      format.html { render action: "esperando_notificacion_analista" }
      format.json { head :ok }
    end
  end

  def verificando_completitud
    screen_name("#{@task.class.to_s}/verificando_completitud")

    respond_to do |format|
      format.html { render action: "verificando_completitud" }
      format.json { head :ok }
    end
  end

  def revisando_documento_completo
    screen_name("#{@task.class.to_s}/revisando_documento_completo")

    respond_to do |format|
      format.html { render action: "revisando_documento_completo" }
      format.json { head :ok }
    end
  end

  def asignando_tareas
    screen_name("#{@task.class.to_s}/asignando_tareas")

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end

  def publicando_diario_de_sesiones
    screen_name("#{@task.class.to_s}/publicando_diario_de_sesiones")

    respond_to do |format|
      format.html { render action: "publicando_diario_de_sesiones" }
      format.json { head :ok }
    end
  end

  def notificando_equipos
    screen_name("#{@task.class.to_s}/notificando_equipos")

    respond_to do |format|
      format.html { render action: "notificando_equipos" }
      format.json { head :ok }
    end
  end

  def publicar
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    # mark current task and current OT complete
    @task.mark_complete
    @ot.mark_complete

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'El documento fue publicado.' }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def recibe_notificacion_analista_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:recibe_notificacion_analista)

    respond_to do |format|
      format.html { render action: "verificando_completitud" }
      format.json { head :ok }
    end
  end

  def trabajo_completo_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:trabajo_completo)

    respond_to do |format|
      format.html { render action: "revisando_documento_completo" }
      format.json { head :ok }
    end
  end

  def trabajo_incompleto_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:trabajo_incompleto)

    respond_to do |format|
      format.html { render action: "esperando_notificacion_analista" }
      format.json { head :ok }
    end
  end

  def evalua_trabajo_terminado_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:evalua_trabajo_terminado)

    respond_to do |format|
      format.html { render action: "publicando_diario_de_sesiones" }
      format.json { head :ok }
    end
  end

  def evalua_trabajo_incompleto_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:evalua_trabajo_incompleto)

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
      format.html { render action: "notificando_equipos" }
      format.json { head :ok }
    end
  end
end
