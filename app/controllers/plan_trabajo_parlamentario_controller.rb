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

  def create_mock_params(legislature, session, session_date, status)
    params = Hash.new

    params[:ot_id] = @ot.id
    params[:legislature] = legislature
    params[:session] = session
    params[:session_date] = session_date
    params[:status] = status

    generated_param = TpGeneratedParam.new(params)
    generated_param.save
  end

  # This is a mock result set, 3 DS marked up, 2 to-be-marked and 2 missing
  # The system, based on an SPARQL query using the parameters provided by the user,
  # discovers a set of DSs that are relevant to the query.
  def apply_parameters
    clear_generated_params
    create_mock_params(359, 77, DateTime.parse("14/12/2011 09:00:00 -0300"), "Marcada")
    create_mock_params(359, 79, DateTime.parse("15/12/2011 09:00:00 -0300"), "Marcada")
    create_mock_params(359, 80, DateTime.parse("15/12/2011 15:00:00 -0300"), "Marcada")
    create_mock_params(359, 81, DateTime.parse("20/12/2011 09:00:00 -0300"), "Sin marcar")
    create_mock_params(359, 82, DateTime.parse("20/12/2011 15:00:00 -0300"), "Sin marcar")
    create_mock_params(359, 83, DateTime.parse("21/12/2011 09:00:00 -0300"), "No existe DS")
    create_mock_params(359, 84, DateTime.parse("21/12/2011 15:00:00 -0300"), "No existe DS")
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
    when "revisando_resultados"
      revisando_resultados
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
    Rails.logger.debug("@@@@ ot = #{@ot.id}")
    Rails.logger.debug("@@@@ task = #{@task.id}")

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

  def revisando_resultados
    screen_name("#{@task.class.to_s}/revisando_resultados")

    @tp_param = TpParameter.where("ot_id = #{@ot.id}").order("session")
    @pt_generated_params = TpGeneratedParam.where("ot_id = #{@ot.id}").order("session")

    respond_to do |format|
      format.html { render action: "revisando_resultados" }
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
