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
        do_perform_transition(:periodo_determinado)

        format.html { redirect_to root_path, notice: 'Poblamiento param was successfully created.' }
      else
        format.html { render action: "determina_periodo" }
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

  def generate_senate_ds_for(effective_date)
    params = Hash.new
    params[:created_by] = current_user.id
    params[:created_on] = DateTime.now
    params[:ot_type_id] = 3
    params[:priority_id] = 3
    params[:target_date] = DateTime.now + 2
    params[:parent_ot_id] = @ot.id
    params[:by_request_of] = @ot.by_request_of

    target_ot = Ot.new(params)
    target_ot.observations << generate_observation(effective_date)
    target_ot.save

    generate_audit(target_ot)
    target_ot.create_tasks(current_user)
  end

  # POST plan_poblamiento_create_genera_ots
  def create_genera_ots
    @ot = Ot.find(params[:ot_id])
    @task = Task.find(@ot.current_task_id)

    @ot.poblamiento_param.start_date.upto(@ot.poblamiento_param.end_date) do |day|
      generate_senate_ds_for(day)
    end

    do_perform_transition(:ots_generadas)
    @ot.mark_complete
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
end