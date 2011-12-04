require 'workflow_controller'

class MarcadoCuentaController < ApplicationController
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
    when "por_asignar"
      por_asignar
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

  # This state should never be activated.
  def por_asignar
    screen_name("#{@task.class.to_s}/por_asignar")

    respond_to do |format|
      format.html { render action: "por_asignar" }
      format.json { head :ok }
    end
  end

  # This is the first "active" state in the workflow
  def asignada
    screen_name("#{@task.class.to_s}/asignada")

    respond_to do |format|
      format.html { render action: "asignada" }
      format.json { head :ok }
    end
  end

  # The analist is looking at and evaluating the results of automatic markup
  def evaluando_resultados
    screen_name("#{@task.class.to_s}/evaluando_resultados")

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  # The analist is manually correcting the marked document
  def corrigiendo_manualmente
    screen_name("#{@task.class.to_s}/corrigiendo_manualmente")

    # Need a document
    check_for_target_document

    # Read it so we can display it
    @xml_text = get_dummy_text

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "corrigiendo_manualmente" }
      format.json { head :ok }
    end
  end

  # POST save_xml_document
  def save_xml_document
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task.id)

    screen_name("#{@task.class.to_s}/corrigiendo_manualmente")

    # Read it so we can display it
    @xml_text = get_dummy_text

    # Mimic saving document to versioning repository
    generate_new_document_version(2)

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "corrigiendo_manualmente" }
      format.json { head :ok }
    end
  end

  # The analist is about to engage automatic markup
  def en_marcaje_automatico
    screen_name("#{@task.class.to_s}/en_marcaje_automatico")

    @am_configuration = generate_skeleton_am_configuration(@ot.id)

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  # The analist is done and informs qa
  def enviada_a_qa
    screen_name("#{@task.class.to_s}/enviada_a_qa")

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def requiere_marcaje_automatico_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    @am_configuration = generate_skeleton_am_configuration(@ot.id)

    do_perform_transition("requiere_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  def no_requiere_marcaje_automatico_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    do_perform_transition("no_requiere_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def requiere_modificaciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("requiere_modificaciones")

    # Need a document
    check_for_target_document

    # Read it so we can display it
    @xml_text = get_dummy_text

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

    respond_to do |format|
      format.html { render action: "corrigiendo_manualmente" }
      format.json { head :ok }
    end
  end

  def no_requiere_modificaciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("no_requiere_modificaciones")

    # Wrap this task up
    next_task = @task.successor
    call_next_workflow(next_task)

    # Make first transition
    @task = next_task
    do_perform_transition(:recibe_notificacion)

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  def termina_correcciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("termina_correcciones")

    # Wrap this task up
    next_task = @task.successor
    call_next_workflow(next_task)

    # Make first transition
    @task = next_task
    do_perform_transition(:recibe_notificacion)

    respond_to do |format|
      format.html { render action: "enviada_a_qa" }
      format.json { head :ok }
    end
  end

  def verifica_correcciones_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    @am_configuration = generate_skeleton_am_configuration(@ot.id)

    do_perform_transition("verifica_correcciones")

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  # Automatic markup is performed here after user selects configuration
  # POST realizar_marcaje_automatico
  def realizar_marcaje_automatico
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    # Save the configuration choices
    @am_configuration = AmConfiguration.new(params[:am_configuration])
    @am_configuration.save

    @am_result = perform_am(@am_configuration)
  
    do_perform_transition("termina_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
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
end
