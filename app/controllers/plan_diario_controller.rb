class PlanDiarioController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 0
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

    @frbr_work = create_source_document_template

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
        @ot.assign_source(@frbr_work.frbr_expressions[0].frbr_manifestations[0])

        # Bump task to next step
        do_perform_transition(:documentos_elegidos)

        format.html { redirect_to root_path, notice: 'El documento Frbr fue creado sin problemas.' }
      else
        format.html { render action: "eligiendo_documento" }
      end
    end
  end

  def en_marcaje_automatico
    screen_name("#{@task.class.to_s}/en_marcaje_automatico")

    @am_configuration = generate_skeleton_am_configuration(@ot.id)

    respond_to do |format|
      format.html { render action: "en_marcaje_automatico" }
      format.json { head :ok }
    end
  end

  # POST realizar_marcaje_automatico
  def realizar_marcaje_automatico
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    @am_configuration = AmConfiguration.new(params[:am_configuration])
    @am_configuration.save

    @am_result = perform_am(@am_configuration)

    do_perform_transition("termina_marcaje_automatico")

    respond_to do |format|
      format.html { render action: "evaluando_resultados" }
      format.json { head :ok }
    end
  end

  def evaluando_resultados
    screen_name("#{@task.class.to_s}/evaluando_resultados")

    # Need a document
    check_for_target_document

    # Read it so we can display it
    @xml_text = get_dummy_text

    @am_result = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC").first

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

    @xml_text = get_dummy_text

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

    @xml_text = get_dummy_text

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

    do_perform_transition(:tareas_divididas)

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

    do_perform_transition(:tareas_asignadas)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Las tareas fueron asignadas sin dificultades.' }
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

    # If this is a partioned OT, generate the post-markup workflow
    if @ot.is_multiple_task?
      @ot.add_markup_diario_post_tasks(current_user)
    end

    # This task needs to be marked complete
    @task.mark_complete

    # Call next workflows, in this case, all workflows associated with analysts
    @ot.tasks.each do |task|
      if task.task_type.ordinal == TaskType::TASK_TYPE_MARK_GENERIC_MARKUP
        call_next_workflow(task, false)
        # Make first transition
        @task = task
        do_perform_transition(:asignacion)
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Los equipos fueron notificados.' }
      format.json { head :ok }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def termina_evaluacion_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:termina_evaluacion)

    respond_to do |format|
      format.html { render action: "planifica_asignar_tareas" }
      format.json { head :ok }
    end
  end

  def decide_dividir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:decide_dividir)

    @xml_text = get_dummy_text
    @tasks = @ot.tasks

    respond_to do |format|
      format.html { render action: "dividir_tareas" }
      format.json { head :ok }
    end
  end

  def decide_no_dividir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:decide_no_dividir)

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
end
