class PlanTrabajoParlamentarioController < ApplicationController
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
    when "inicial"
      inicial
    when "definiendo_parametros"
      definiendo_parametros
    when "revisando_parametros"
      revisando_parametros
    when "generando_modelo"
      generando_modelo
    when "generando_ots"
      generando_ots
    end
  end

  def inicial
    screen_name("#{@task.class.to_s}/inicial")

    respond_to do |format|
      format.html { render action: "inicial" }
      format.json { head :ok }
    end
  end

  def definiendo_parametros
    screen_name("#{@task.class.to_s}/definiendo_parametros")

    respond_to do |format|
      format.html { render action: "definiendo_parametros" }
      format.json { head :ok }
    end
  end

  def revisando_parametros
    screen_name("#{@task.class.to_s}/revisando_parametros")

    respond_to do |format|
      format.html { render action: "revisando_parametros" }
      format.json { head :ok }
    end
  end

  def generando_modelo
    screen_name("#{@task.class.to_s}/generando_modelo")

    respond_to do |format|
      format.html { render action: "generando_modelo" }
      format.json { head :ok }
    end
  end

  def generando_ots
    screen_name("#{@task.class.to_s}/generando_ots")

    respond_to do |format|
      format.html { render action: "generando_ots" }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def comienza_definir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:comienza_definir)

    respond_to do |format|
      format.html { render action: "definiendo_parametros" }
      format.json { head :ok }
    end
  end

  def termina_definir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:termina_definir)

    respond_to do |format|
      format.html { render action: "revisando_parametros" }
      format.json { head :ok }
    end
  end

  def rechaza_parametros_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:rechaza_parametros)

    respond_to do |format|
      format.html { render action: "definiendo_parametros" }
      format.json { head :ok }
    end
  end

  def acepta_parametros_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:acepta_parametros)

    respond_to do |format|
      format.html { render action: "generando_modelo" }
      format.json { head :ok }
    end
  end

  def rechaza_modelo_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:rechaza_modelo)

    respond_to do |format|
      format.html { render action: "definiendo_parametros" }
      format.json { head :ok }
    end
  end

  def acepta_modelo_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:acepta_modelo)

    respond_to do |format|
      format.html { render action: "generando_ots" }
      format.json { head :ok }
    end
  end
end
