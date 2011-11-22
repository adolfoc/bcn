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

  # Nobody logged on -- show empty screen
  def show_empty
    screen_name("Inicial")

    respond_to do |format|
      format.html { render action: "show_empty" }
      format.json { head :ok }
    end
  end

  # Show analist's trays
  def show_analist
    screen_name("Inicial-Analista")

    @ots_incoming = Array.new
    @ots_work = Array.new
    @ots_sent = Array.new
    Ot.all.each do |ot|
      if !ot.current_task.nil?
        if ot.current_task.current_user_id == current_user.id && ot.read == false
          @ots_incoming << ot
        elsif ot.current_task.current_user_id == current_user.id && ot.read == true
          @ots_work << ot
        elsif ot.created_by == current_user.id || ot.has_been_worked_on_by(current_user.id)
          @ots_sent << ot
        end
      end
    end

    respond_to do |format|
      format.html { render action: "show_analist" }
      format.json { head :ok }
    end
  end

  # Show QA analist's trays
  def show_qa_analist
    screen_name("Inicial-Analista-QA")

    @ots_incoming = Array.new
    @ots_work = Array.new
    @ots_sent = Array.new
    Ot.all.each do |ot|
      if !ot.current_task.nil?
        if ot.current_task.current_user_id == current_user.id && ot.read == false
          @ots_incoming << ot
        elsif ot.current_task.current_user_id == current_user.id && ot.read == true
          @ots_work << ot
        elsif ot.created_by == current_user.id
          @ots_sent << ot
        end
      end
    end

    respond_to do |format|
      format.html { render action: "show_qa_analist" }
      format.json { head :ok }
    end
  end

  # Show planner's trays
  def show_planner
    screen_name("Inicial-Planificador")

    @ots_incoming = Array.new
    @ots_work = Array.new
    @ots_sent = Array.new
    Ot.all.each do |ot|
      if !ot.current_task.nil?
        if ot.current_task.current_user_id == current_user.id && ot.read == false
          @ots_incoming << ot
        elsif ot.current_task.current_user_id == current_user.id && ot.read == true
          @ots_work << ot
        elsif ot.created_by == current_user.id
          @ots_sent << ot
        end
      end
    end

    respond_to do |format|
      format.html { render action: "show_planner" }
      format.json { head :ok }
    end
  end

  # Show admin's trays, similar to planner's
  def show_admin
    screen_name("Inicial-Admin")

    @ots_incoming = Array.new
    @ots_work = Array.new
    @ots_sent = Array.new
    Ot.all.each do |ot|
      if !ot.current_task.nil?
        if ot.current_task.current_user_id == current_user.id && ot.read == false
          @ots_incoming << ot
        elsif ot.current_task.current_user_id == current_user.id && ot.read == true
          @ots_work << ot
        elsif ot.created_by == current_user.id
          @ots_sent << ot
        end
      end
    end

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

    @observations = Observation.where("ot_id = #{@ot.id}")
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

    if current_user.role.id == 3 || current_user.role.id == 5
      @task = @ot.current_task
    end
  end

  def show_document
    screen_name("Mostrar-Documento")

    @document = FrbrManifestation.find(params[:frbr_manifestation_id])
  end

  def create_observation
    params[:observation][:user_id] = current_user.id
    @observation = Observation.new(params[:observation])

    @ot = Ot.find(params[:observation][:ot_id])
    @observations = Observation.where("ot_id = #{@ot.id}")
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC").paginate(:page => params[:page], :per_page => 10)

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
    FrbrManifestation.delete_all
    FrbrExpression.delete_all
    FrbrWork.delete_all
    Task.delete_all
    Observation.delete_all
    Ot.delete_all

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Base de datos limpiada.' }
    end
  end
end
