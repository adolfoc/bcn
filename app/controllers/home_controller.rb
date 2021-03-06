class HomeController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  # Dispatch according to who is logged on
  def index
    if current_user.nil?
      show_empty
    elsif current_user.role.id == 1
      show_analist
    elsif current_user.role.id == 2
      show_qa_analist
    elsif current_user.role.id == 3
      show_planner
    elsif current_user.role.id == 5
      show_admin
    else
      show_empty
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

  def new_ot
    screen_name("Admin-Nueva-OT")
    @ot = Ot.new
    @ot.created_by = current_user.id
    @ot.target_date = DateTime.now + 2

    observation = Observation.new
    observation.user_id = current_user.id
    @ot.observations << observation

    respond_to do |format|
      format.html # new_ot.html.erb
    end
  end

  # POST /create_new_ot
  def create_new_ot
    params[:ot].delete(:observations_attributes) if params[:ot][:observations_attributes]["0"][:contents].length == 0
    @ot = Ot.new(params[:ot])

    respond_to do |format|
      if @ot.save
        generate_audit(@ot)
        @ot.create_tasks(current_user)
        format.html { redirect_to root_path, notice: 'La OT fue creada sin dificultades.' }
      else
        format.html { render action: "new_ot" }
      end
    end
  end

  # Nobody logged on -- show empty screen
  def show_empty
    screen_name("Inicial")

    respond_to do |format|
      format.html { render action: "show_empty" }
      format.json { head :ok }
    end
  end

  def distribute_ots
    @tasks_incoming = Array.new
    @tasks_work = Array.new
    @ots_sent = Array.new
    ots_covered = Array.new
    Ot.order("updated_at DESC").each do |ot|
      if !ot.current_task.nil?
        ot.tasks.each do |task|
          if task.is_active? && task.current_user_id == current_user.id && ot.read == false
            @tasks_incoming << task
            ots_covered << ot
          elsif task.is_active? && task.current_user_id == current_user.id && task.ot.read == true && task.ot.completed_on.nil?
            @tasks_work << task
            ots_covered << ot
          end
        end
        if (ot.owner.id == current_user.id || ot.has_been_worked_on_by(current_user.id)) && !ots_covered.include?(ot)
          @ots_sent << ot
        end
      end
    end
  end

  # Show analist's trays
  def show_analist
    screen_name("Inicial-Analista")

    distribute_ots

    respond_to do |format|
      format.html { render action: "show_analist" }
      format.json { head :ok }
    end
  end

  # Show QA analist's trays
  def show_qa_analist
    screen_name("Inicial-Analista-QA")

    distribute_ots

    respond_to do |format|
      format.html { render action: "show_qa_analist" }
      format.json { head :ok }
    end
  end

  # Show planner's trays
  def show_planner
    screen_name("Inicial-Planificador")

    distribute_ots

    respond_to do |format|
      format.html { render action: "show_planner" }
      format.json { head :ok }
    end
  end

  # Show admin's trays, similar to planner's
  def show_admin
    screen_name("Inicial-Admin")

    distribute_ots

    respond_to do |format|
      format.html { render action: "show_admin" }
      format.json { head :ok }
    end
  end

  # Show a specific OT
  def show_ot
    screen_name("Mostrar-OT")

    @ot = Ot.find(params[:ot_id])
    @ot.mark_read

    @am_results = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC")
    @observations = Observation.where("ot_id = #{@ot.id}")
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @versions = TargetDocumentVersion.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    if current_user.role.id == 3 || current_user.role.id == 5
      @task = @ot.current_task
    end
  end

  # GET edit_ot
  def edit_ot
    screen_name("Editar-OT")

    @ot = Ot.find(params[:ot_id])
    @task = @ot.current_task
  end

  # POST update_ot
  def update_ot
    @ot = Ot.find(params[:ot][:id])

    respond_to do |format|
      if @ot.update_attributes(params[:ot])
        format.html { redirect_to root_path, notice: 'Ot was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit_ot" }
        format.json { render json: @ot.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_document
    screen_name("Mostrar-Documento")

    @document = FrbrManifestation.find(params[:frbr_manifestation_id])
  end

  def show_am_result
    screen_name("Mostrar-Resultado-MA")

    @am_result = AmResult.find(params[:am_result_id])
    @ot = Ot.find(@am_result.ot_id)
    @task = @ot.current_task
  end

  def create_observation
    params[:observation][:user_id] = current_user.id
    @observation = Observation.new(params[:observation])

    @ot = Ot.find(params[:observation][:ot_id])
    @am_results = AmResult.where("ot_id = #{@ot.id}").order("run_date DESC")
    @observations = Observation.where("ot_id = #{@ot.id}")
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @versions = TargetDocumentVersion.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      if @observation.save
        format.html { render action: "show_ot" }
        format.json { render json: @observation, status: :created, location: @observation }
      else
        format.html { render action: "show_ot" }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  def clear_database
    Audit.delete_all
    AmConfiguration.delete_all
    AmObservation.delete_all
    AmResult.delete_all
    FrbrManifestation.delete_all
    FrbrExpression.delete_all
    FrbrWork.delete_all
    TargetDocumentVersion.delete_all
    Task.delete_all
    Observation.delete_all
    PoblamientoParam.delete_all
    PoblamientoGeneratedParam.delete_all
    TpParameter.delete_all
    TpGeneratedParam.delete_all
    Ot.delete_all

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Base de datos limpiada.' }
    end
  end
end
