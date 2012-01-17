class PlanTrabajoParlamentarioController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 0
  end

  def clear_generated_params
    TpGeneratedParam.delete_all("ot_id = #{@ot.id}")
  end

  def create_mock_params(legislature, session, session_date, status, action)
    params = Hash.new

    params[:ot_id] = @ot.id
    params[:legislature] = legislature
    params[:session] = session
    params[:session_date] = session_date
    params[:status] = status
    params[:action] = action

    generated_param = TpGeneratedParam.new(params)
    generated_param.save
  end

  # This is a mock result set, 3 DS marked up, 2 to-be-marked and 2 missing
  # The system, based on an SPARQL query using the parameters provided by the user,
  # discovers a set of DSs that are relevant to the query.
  def apply_parameters
    clear_generated_params
    create_mock_params(359, 77, DateTime.parse("14/12/2011 09:00:00 -0300"), "Marcada", "Ninguna")
    create_mock_params(359, 79, DateTime.parse("15/12/2011 09:00:00 -0300"), "Marcada", "Ninguna")
    create_mock_params(359, 80, DateTime.parse("15/12/2011 15:00:00 -0300"), "Marcada", "Ninguna")
    create_mock_params(359, 81, DateTime.parse("20/12/2011 09:00:00 -0300"), "Marcado parcialmente", "Generar OT Ingreso Parcial")
    create_mock_params(359, 82, DateTime.parse("20/12/2011 15:00:00 -0300"), "Sin marcar", "Generar OT Ingreso Parcial")
    create_mock_params(359, 83, DateTime.parse("21/12/2011 09:00:00 -0300"), "No existe DS", "Generar OT Ingreso Anticipado")
    create_mock_params(359, 84, DateTime.parse("21/12/2011 15:00:00 -0300"), "No existe DS", "Generar OT Ingreso Anticipado")
  end

  # TODO: Not DRY
  def generate_audit(ot)
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_audit")
    params = Hash.new
    params[:user_id] = current_user.id
    params[:role_id] = current_user.role.id
    params[:ot_id] = ot.id
    params[:description] = "Creacion de nueva OT tipo #{ot.ot_type.name}"
    log_entry = Audit.new(params)
    log_entry.save
  end

  # TODO: Not DRY
  def generate_frbr_manifestation
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_manifestation")
    params = Hash.new
    params[:document_file_name] = "dummy.doc"
    params[:document_content_type] = "application/msword"
    params[:document_file_size] = 205310
    params[:document_updated_at] = DateTime.now

    frbr_manifestation = FrbrManifestation.new(params)
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_manifestation frbr_manifestation = #{frbr_manifestation.inspect}")

    frbr_manifestation
  end

  # TODO: Not DRY
  def generate_frbr_expression
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_expression")
    params = Hash.new
    params[:frbr_document_type_id] = 1
    params[:version] = 1
    params[:language] = "es"

    frbr_expression = FrbrExpression.new(params)
    frbr_expression.frbr_manifestations << generate_frbr_manifestation
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_expression frbr_expression = #{frbr_expression.inspect}")

    frbr_expression
  end

  # TODO: Not DRY
  def generate_frbr_work(tp_parameter, tp_generated_param)
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_work")
    params = Hash.new
    params[:frbr_bcn_type_id] = 5   # Senate's DS
    params[:frbr_entity_id] = 1     # Senate
    params[:session] = tp_generated_param.session
    params[:legislature] = tp_generated_param.legislature
    params[:delivery_method_id] = 3
    params[:event_date] = tp_generated_param.session_date

    frbr_work = FrbrWork.new(params)
    frbr_work.frbr_expressions << generate_frbr_expression
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_frbr_work frbr_work = #{frbr_work.inspect}")

    frbr_work.save
    frbr_work.frbr_expressions[0].frbr_manifestations[0]
  end

  # TODO: Not DRY
  def generate_senate_ds_for(tp_parameter, tp_generated_param, ot_type_id)
    params = Hash.new
    params[:created_by] = current_user.id
    params[:created_on] = DateTime.now
    params[:ot_type_id] = ot_type_id
    params[:priority_id] = 3
    params[:target_date] = DateTime.now + 2
    params[:parent_ot_id] = @ot.id
    params[:by_request_of] = @ot.by_request_of
    params[:source_frbr_manifestation] = generate_frbr_work(tp_parameter, tp_generated_param)

    target_ot = Ot.new(params)
    target_ot.save
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_senate_ds_for target_ot = #{target_ot.inspect}")

    generate_audit(target_ot)
    target_ot.create_tasks(current_user)

    # Need to temporarily swap pointers here
    save_ot = @ot
    save_task = @task

    @ot = target_ot
    @task = @ot.tasks.first
    do_perform_transition(:documentos_elegidos)

    # Restore pointers
    @ot = save_ot
    @task = save_task
  end

  # TODO: Not DRY
  def generate_one_ot(tp_parameter, tp_generated_param)
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_one_ot tp_parameter = #{tp_parameter.inspect}")
    Rails.logger.debug("@@@ PlanTrabajoParlamentarioController::generate_one_ot tp_generated_param = #{tp_generated_param.inspect}")
    if tp_generated_param.action == "Generar OT Ingreso Parcial"
      generate_senate_ds_for(tp_parameter, tp_generated_param, OtType::OT_TYPE_PARTIAL_DS)
    elsif tp_generated_param.action == "Generar OT Ingreso Anticipado"
      generate_senate_ds_for(tp_parameter, tp_generated_param, OtType::OT_TYPE_ANTICIPATED_DS)
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
    when "inicial"
      inicial
    when "definiendo_parametros"
      definiendo_parametros
    when "modificando_parametros"
      modificando_parametros
    when "revisando_resultados"
      revisando_resultados
    when "generando_ots"
      generando_ots
    when "en_curso"
      en_curso
    when "termina_trabajo_parlamentario"
      termina_trabajo_parlamentario
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
    @tp_parameter = TpParameter.new
    @tp_parameter.ot_id = @ot.id

    respond_to do |format|
      format.html { render action: "definiendo_parametros" }
      format.json { head :ok }
    end
  end

  # POST create_params
  def create_params
    @ot = Ot.find(params[:tp_parameter][:ot_id])
    @task = Task.find(@ot.current_task_id)

    @tp_parameter = TpParameter.new(params[:tp_parameter])

    respond_to do |format|
      if @tp_parameter.save

        # Generate plan
        apply_parameters

        # Move on
        do_perform_transition(:termina_definir)

        format.html { redirect_to root_path, notice: 'Los parametros del trabajo parlamentario fueron creados.' }
        format.json { render json: @tp_parameter, status: :created, location: @tp_parameter }
      else
        format.html { render action: "definiendo_parametros" }
        format.json { render json: @tp_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  def modificando_parametros
    screen_name("#{@task.class.to_s}/modificando_parametros")

    @tp_parameter = TpParameter.find_by_ot_id(@ot.id)

    respond_to do |format|
      format.html { render action: "modificando_parametros" }
      format.json { head :ok }
    end
  end

  # POST update_params
  def update_params
    @ot = Ot.find(params[:tp_parameter][:ot_id])
    @task = Task.find(@ot.current_task_id)

    @tp_parameter = TpParameter.find_by_ot_id(@ot.id)

    respond_to do |format|
      if @tp_parameter.update_attributes(params[:tp_parameter])
        # Generate plan
        apply_parameters

        # Move on
        do_perform_transition(:termina_modificar)

        format.html { redirect_to root_path, notice: 'Los parametros del trabajo parlamentario fueron actualizados' }
      else
        format.html { render action 'modificando_parametros' }
      end
    end
  end

  def revisando_resultados
    screen_name("#{@task.class.to_s}/revisando_resultados")

    @tp_parameter = TpParameter.find_by_ot_id(@ot.id)
    @tp_generated_params = TpGeneratedParam.where("ot_id = #{@ot.id}").order("session")

    respond_to do |format|
      format.html { render action: "revisando_resultados" }
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

  # POST create_genera_ots
  def create_genera_ots
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    @tp_parameter = TpParameter.find_by_ot_id(@ot.id)
    @tp_generated_params = TpGeneratedParam.where("ot_id = #{@ot.id}").order("session")

    @tp_generated_params.each do | tp_generated_param |
      if tp_generated_param.status == "Sin marcar"
        generate_one_ot(@tp_parameter, tp_generated_param)
      elsif tp_generated_param.status == "Marcado parcialmente"
        generate_one_ot(@tp_parameter, tp_generated_param)
      elsif tp_generated_param.status == "No existe DS"
        generate_one_ot(@tp_parameter, tp_generated_param)
      end
    end

    do_perform_transition(:acepta_parametros)
    do_perform_transition(:ots_generadas)

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Las OTs fueron generadas con exito' }
    end
  end

  def en_curso
    screen_name("#{@task.class.to_s}/en_curso")

    respond_to do |format|
      format.html { render action: "en_curso" }
      format.json { head :ok }
    end
  end

  def termina_trabajo_parlamentario
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def comienza_definir_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:comienza_definir)

    @tp_parameter = TpParameter.new
    @tp_parameter.ot_id = @ot.id

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

    @tp_parameter = TpParameter.find_by_ot_id(@ot.id)

    respond_to do |format|
      format.html { render action: "modificando_parametros" }
      format.json { head :ok }
    end
  end

  def acepta_parametros_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:acepta_parametros)

    respond_to do |format|
      format.html { render action: "generando_ots" }
      format.json { head :ok }
    end
  end

  def ots_generadas_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:ots_generadas)

    respond_to do |format|
      format.html { render action: "en_curso" }
      format.json { head :ok }
    end
  end

  def todas_procesadas_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:todas_procesadas)

    respond_to do |format|
      format.html { render action: "termina_poblamiento" }
      format.json { head :ok }
    end
  end
end
