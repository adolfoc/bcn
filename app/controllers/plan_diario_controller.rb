class PlanDiarioController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  # Actions that trigger a change of state
  def do_perform_transition(event)
    @event = event
    perform_transition

    # Refresh task with new state
    @task = Task.find(@task.id)
    @ot = Ot.find(@task.ot_id)
  end

  def check_for_target_document
    # If we don't have an XML file, create one
    if @ot.target_frbr_manifestation_id.nil?
      target_frbr = AutomaticMarkup.generate_initial_markup(@ot.source_frbr_manifestation_id)
      params = Hash.new
      params[:target_frbr_manifestation_id] = target_frbr.id
      @ot.update_attributes(params)
    end
  end

  def perform_work
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @ot.mark_read

    case @task.workflow_state
    when "eligiendo_documento"
      eligiendo_documento
    when "en_marcaje_automatico"
      en_marcaje_automatico
    when "evaluando_resultados"
      evaluando_resultados
    when "planifica_asignar_tareas"
      planifica_asignar_tareas
    when "dividir_tareas"
      dividir_tareas
    when "asignando_tareas"
      asignando_tareas
    when "notificar_qa"
      notificar_qa
    when "notificar_equipos"
      notificar_equipos
    end
  end

  def eligiendo_documento
    screen_name("#{@task.class.to_s}/eligiendo_documento")

    @frbr_work = FrbrWork.new
    frbr_expression = FrbrExpression.new({ :frbr_document_type_id => 3, :version => 1, :language => 'es' })
    @frbr_work.frbr_expressions << frbr_expression
    frbr_manifestation = FrbrManifestation.new
    frbr_expression.frbr_manifestations << frbr_manifestation

    respond_to do |format|
      format.html { render action: "eligiendo_documento" }
      format.json { head :ok }
    end
  end

  def create_document
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)
    @frbr_work = FrbrWork.new(params[:frbr_work])

    respond_to do |format|
      if @frbr_work.save
        # Associate ot to new manifestation
        @ot.source_frbr_manifestation_id = @frbr_work.frbr_expressions[0].frbr_manifestations[0].id
        @ot.save
        # Bump task to next step
        @event = :documentos_elegidos
        perform_transition if !@event.nil?
        perform_end_of_task if !@event.nil?

        format.html { redirect_to root_path, notice: 'El documento Frbr fue creado sin problemas.' }
      else
        format.html { render action: "eligiendo_documento" }
      end
    end
  end

  def en_marcaje_automatico
    screen_name("#{@task.class.to_s}/en_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  def realizar_marcaje_automatico
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    check_for_target_document

    do_perform_transition("termina_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def evaluando_resultados
    screen_name("#{@task.class.to_s}/evaluando_resultados")

    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def planifica_asignar_tareas
    screen_name("#{@task.class.to_s}/planifica_asignar_tareas")

    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    respond_to do |format|
      format.html { render action: "planifica_asignar_tareas" }
      format.json { head :ok }
    end
  end

  def dividir_tareas
    screen_name("#{@task.class.to_s}/dividir_tareas")

    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @tasks = @ot.tasks.select { |task| true if task.id != @task.id }

    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    respond_to do |format|
      format.html { render action: "dividir_tareas" }
      format.json { head :ok }
    end
  end

  def agregar_tarea
    screen_name("#{@task.class.to_s}/dividir_tareas")

    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @ot.add_markup_diario_tasks(current_user)
    @tasks = @ot.tasks.select { |task| true if task.id != @task.id }

    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    @xml_text = File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }

    respond_to do |format|
      format.html { render action: "dividir_tareas" }
      format.json { head :ok }
    end
  end

  def create_dividir_tareas
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    params[:tarea].each_key do |key|
      if key != @task.id
        this_task = Task.find(key)

        update_params = Hash.new
        update_params[:current_user_id] = params[:tarea][key][:user]
        update_params[:xpath_section] = params[:tarea][key][:xpath]
        this_task.update_attributes(update_params)
      end
    end

    # Bump task to next step
    @event = :tareas_divididas
    perform_transition if !@event.nil?
    perform_end_of_task if !@event.nil?

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Las tareas fueron asignadas sin dificultades.' }
      format.json { head :ok }
    end
  end

  def asignando_tareas
    screen_name("#{@task.class.to_s}/asignando_tareas")

    # Generate tasks
    @tasks = []
    @ot.tasks.each do |task|
      @tasks << task if task.id != @task.id
    end

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end

  def create_asignar_tareas
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)
    params[:tarea].each_pair do |key, value|
      if key != @task.id
        this_task = Task.find(key)

        update_params = Hash.new
        update_params[:current_user_id] = value
        this_task.update_attributes(update_params)
      end
    end

    # Bump task to next step
    @event = :tareas_asignadas
    perform_transition if !@event.nil?
    perform_end_of_task if !@event.nil?

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Las tareas fueron asignadas sin dificultades.' }
      format.json { head :ok }
    end
  end

  def notificar_qa
    screen_name("#{@task.class.to_s}/notificar_qa")

    respond_to do |format|
      format.html { render action: "notificar_qa" }
      format.json { head :ok }
    end
  end

  def notificar_equipos
    screen_name("#{@task.class.to_s}/notificar_equipos")

    respond_to do |format|
      format.html { render action: "notificar_equipos" }
      format.json { head :ok }
    end
  end

  def create_notificar_equipos
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    # Call next workflows, in this case, all workflows associated with analysts
    next_task = @ot.tasks.select { |task| true if task.task_type.ordinal == TaskType::TASK_TYPE_MARK_DS_SENATE_MARKUP }.first
    @ot.current_task_id = next_task.id
    @ot.current_step = next_task.initial_task.to_s
    @ot.save

    create_log_entry_for_workflow(@task.name, next_task.name)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Los equipos fueron notificados.' }
      format.json { head :ok }
    end
  end

  # Events and transitions
  def no_hay_errores_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("no_hay_errores")

    respond_to do |format|
      format.html { render action: "notificar_qa" }
      format.json { head :ok }
    end
  end

  def hay_errores_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("hay_errores")

    respond_to do |format|
      format.html { render action: "planifica_asignar_tareas" }
      format.json { head :ok }
    end
  end

  def decide_dividir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("decide_dividir")

    @tasks = @ot.tasks

    respond_to do |format|
      format.html { render action: "dividir_tareas" }
      format.json { head :ok }
    end
  end

  def decide_no_dividir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition("decide_no_dividir")

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end
end
