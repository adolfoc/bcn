require 'workflow_controller'

class PlanPoblamientoController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 0
  end

  def clear_generated_params
    PoblamientoGeneratedParam.delete_all("ot_id = #{@ot.id}")
  end

  def decode_legislature_from_date(poblamiento_param, day)
    212
  end

  def decode_session_from_date(poblamiento_param, day)
    day.yday
  end

  def generate_driving_param(day, poblamiento_param)
    params = Hash.new
    params[:ot_id] = @ot.id
    params[:legislature] = decode_legislature_from_date(poblamiento_param.frbr_entity, day)
    params[:session] = decode_session_from_date(poblamiento_param.frbr_entity, day)
    params[:session_date] = day
    params[:processing] = "Completo"

    generated_param = PoblamientoGeneratedParam.new(params)
    generated_param.save
  end

  def generate_driving_params
    @ot.poblamiento_param.start_date.upto(@ot.poblamiento_param.end_date) do |day|
      generate_driving_param(day, @ot.poblamiento_param) if day.wday >= 2 && day.wday <= 4
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
    when "determina_periodo"
      determina_periodo
    when "revisando_parametros"
      revisando_parametros
    when "modificar_periodo"
      modificar_periodo
    when "genera_ots"
      genera_ots
    when "termina_poblamiento"
      termina_poblamiento
    end
  end

  # GET determina_periodo
  def determina_periodo
    @poblamiento_param = PoblamientoParam.new
    @poblamiento_param.ot_id = @ot.id

    respond_to do |format|
      format.html { render "determina_periodo" }
    end
  end

  # POST create_params
  def create_params
    @ot = Ot.find(params[:poblamiento_param][:ot_id])
    @task = Task.find(@ot.current_task_id)

    @poblamiento_param = PoblamientoParam.new(params[:poblamiento_param])

    respond_to do |format|
      if @poblamiento_param.save
        generate_driving_params
        do_perform_transition(:periodo_determinado)

        format.html { redirect_to root_path, notice: 'Poblamiento param was successfully created.' }
      else
        format.html { render action: "determina_periodo" }
      end
    end
  end

  # GET revisando_parametros
  def revisando_parametros
    @poblamiento_param = @ot.poblamiento_param
    @poblamiento_generated_params = PoblamientoGeneratedParam.where("ot_id = #{@ot.id}").order("session_date")

    respond_to do |format|
      format.html { render "revisando_parametros" }
    end
  end

  # GET modificar_periodo
  def modificar_periodo
    @poblamiento_param = @ot.poblamiento_param

    respond_to do |format|
      format.html { render "modificar_periodo" }
    end
  end

  # POST update_params
  def update_params
    @ot = Ot.find(params[:poblamiento_param][:ot_id])
    @task = Task.find(@ot.current_task_id)

    @poblamiento_param = PoblamientoParam.where("ot_id = #{@ot.id}").first
    @poblamiento_generated_params = PoblamientoGeneratedParam.where("ot_id = #{@ot.id}").order("session_date")

    respond_to do |format|
      if @poblamiento_param.update_attributes(params[:poblamiento_param])
        clear_generated_params
        generate_driving_params
        do_perform_transition(:periodo_modificado)

        format.html { 
          render "revisando_parametros"
        }
        format.json { head :ok }
      else
        format.html { render action: "modificar_periodo" }
        format.json { render json: @poblamiento_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET genera_ots
  def genera_ots
    @poblamiento_param = @ot.poblamiento_param

    respond_to do |format|
      format.html { render "genera_ots" }
    end
  end

  def generate_audit(ot)
    params = Hash.new
    params[:user_id] = current_user.id
    params[:role_id] = current_user.role.id
    params[:ot_id] = ot.id
    params[:description] = "Creacion de nueva OT tipo #{ot.ot_type.name}"
    log_entry = Audit.new(params)
    log_entry.save
  end

  def generate_observation(effective_date)
    params = Hash.new
    params[:user_id] = current_user.id
    params[:observation_type_id] = ObservationType.find_by_ordinal(ObservationType::OBS_TYPE_INSTRUCTION).id
    params[:contents] = "Generar documento del #{effective_date}"

    Observation.new(params)
  end

  def generate_frbr_manifestation(pp, pgp)
    params = Hash.new
    params[:document_file_name] = "dummy.doc"
    params[:document_content_type] = "application/msword"
    params[:document_file_size] = 205310
    params[:document_updated_at] = DateTime.now

    frbr_manifestation = FrbrManifestation.new(params)
    frbr_manifestation
  end

  def generate_source_expression(pp, pgp)
    params = Hash.new
    params[:frbr_document_type_id] = 1
    params[:version] = 1
    params[:language] = "es"

    frbr_expression = FrbrExpression.new(params)
    frbr_expression.frbr_manifestations << generate_frbr_manifestation(pp, pgp)
    frbr_expression
  end

  def generate_source_document(pp, pgp)
    params = Hash.new
    params[:frbr_bcn_type_id] = 5
    params[:frbr_entity_id] = pp.frbr_entity_id
    params[:session] = pgp.session
    params[:legislature] = pgp.legislature
    params[:delivery_method_id] = 3
    params[:intermediary_id] = pp.intermediary_id
    params[:event_date] = pgp.session_date

    frbr_work = FrbrWork.new(params)

    frbr_work.frbr_expressions << generate_source_expression(pp, pgp)

    frbr_work.save
    frbr_work.frbr_expressions[0].frbr_manifestations[0]
  end

  def generate_senate_ds_for(pp, pgp)
    params = Hash.new
    params[:created_by] = current_user.id
    params[:created_on] = DateTime.now
    params[:ot_type_id] = 3
    params[:priority_id] = 3
    params[:target_date] = DateTime.now + 2
    params[:parent_ot_id] = @ot.id
    params[:by_request_of] = @ot.by_request_of
    params[:source_frbr_manifestation] = generate_source_document(pp, pgp)

    target_ot = Ot.new(params)
    target_ot.observations << generate_observation(pgp.session_date)
    target_ot.save

    generate_audit(target_ot)
    target_ot.create_tasks(current_user)

    save_ot = @ot
    save_task = @task

    @ot = target_ot
    @task = @ot.tasks.first
    do_perform_transition(:documentos_elegidos)

    @ot = save_ot
    @task = save_task
  end

  def generate_one_ot(pp, pgp)
    generate_senate_ds_for(pp, pgp)
  end

  # POST plan_poblamiento_create_genera_ots
  def create_genera_ots
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    @poblamiento_param = PoblamientoParam.where("ot_id = #{@ot.id}").first
    @poblamiento_generated_params = PoblamientoGeneratedParam.where("ot_id = #{@ot.id}").order("session_date")

    @poblamiento_generated_params.each do |pgp|
      generate_one_ot(@poblamiento_param, pgp)
    end

    do_perform_transition(:aceptar_parametros)
    do_perform_transition(:ots_generadas)
    @task.mark_complete

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Las OTs fueron generadas con exito' }
    end
  end

  # GET termina_poblamiento
  def termina_poblamiento
    respond_to do |format|
      format.html { render "termina_poblamiento" }
    end
  end

  ##########################################################
  # Controller interface: Events and transitions
  ##########################################################

  def periodo_determinado_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:periodo_determinado)

    respond_to do |format|
      format.html { render action: "revisando_parametros" }
      format.json { head :ok }
    end
  end

  def aceptar_parametros_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:aceptar_parametros)

    respond_to do |format|
      format.html { render action: "genera_ots" }
      format.json { head :ok }
    end
  end

  def rechazar_parametros_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:rechazar_parametros)
    @poblamiento_param = PoblamientoParam.where("ot_id = #{@ot.id}").first

    respond_to do |format|
      format.html { render action: "modificar_periodo" }
      format.json { head :ok }
    end
  end

  def periodo_modificado_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:periodo_modificado)
    @poblamiento_generated_params = PoblamientoGeneratedParam.where("ot_id = #{@ot.id}").order("session_date")

    respond_to do |format|
      format.html { render action: "revisando_parametros" }
      format.json { head :ok }
    end
  end

  def ots_generadas_event
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)

    do_perform_transition(:ots_generadas)

    respond_to do |format|
      format.html { render action: "termina_poblamiento" }
      format.json { head :ok }
    end
  end
end