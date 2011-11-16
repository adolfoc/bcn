require 'workflow_controller'

class MarcadoCuentaController < ApplicationController
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
    when "asignada"
      asignada
    when "evaluando_resultados"
      evaluando_resultados
    when "corrigiendo_manualmente"
      corrigiendo_manualmente
    when "en_marcaje_automatico"
      en_marcaje_automatico
    when "enviada_a_qa"
      enviada_a_qa
    end
  end

  # Actions that bring back a state
  def asignada
    screen_name("#{@task.class.to_s}/asignada")

    respond_to do |format|
      format.html { render action: "asignada" }
      format.json { head :ok }
    end
  end

  def evaluando_resultados
    screen_name("#{@task.class.to_s}/evaluando_resultados")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def corrigiendo_manualmente
    screen_name("#{@task.class.to_s}/corrigiendo_manualmente")

    @xml_text = '<?xml version="1.0" encoding="UTF-8"?>
    <?xml-stylesheet type="text/css" href="diario.css"?>
    <akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:schemaLocation="http://www.akomantoso.org/2.0 ./akomantoso20.xsd" 
        xmlns="http://www.akomantoso.org/2.0">
    	<debate>
    	</debate>
    </akomaNtoso>'

    respond_to do |format|
      format.html { render action: "corrigiendo_manualmente" }
      format.json { head :ok }
    end
  end

  def en_marcaje_automatico
    screen_name("#{@task.class.to_s}/en_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  def enviada_a_qa
    screen_name("#{@task.class.to_s}/enviada_a_qa")

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  # Actions that trigger a change of state
  def do_perform_transition(event)
    @event = event
    perform_transition

    # Refresh task with new state
    @task = Task.find(@task.id)
    @ot = Ot.find(@task.ot_id)
  end

  def comienza_evaluar_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("comienza_evaluar")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def requiere_modificaciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("requiere_modificaciones")

    respond_to do |format|
      format.html { render action: "corrigiendo_manualmente" }
      format.json { head :ok }
    end
  end

  def no_requiere_modificaciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    # Call next workflow
    next_task = @ot.tasks.select { |task| true if task.task_type_id == 5 }.first
    @ot.current_task_id = next_task.id
    @ot.current_step = next_task.initial_task.to_s
    @ot.save

    create_log_entry_for_workflow(@task.name, next_task.name)

    # Refresh task with new state
    @task = Task.find(params[:task_id])

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  def termina_correcciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("termina_correcciones")

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  def verifica_correcciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("verifica_correcciones")

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  def termina_marcaje_automatico_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("termina_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def realizar_marcaje_automatico
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("termina_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end
end
