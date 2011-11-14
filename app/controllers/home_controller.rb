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

    @tasks = Task.where("current_user_id = #{current_user.id}")

    respond_to do |format|
      format.html { render action: "show_analist" }
      format.json { head :ok }
    end
  end

  # Show QA analist's trays
  def show_qa_analist
    screen_name("Inicial-Analista-QA")

    @tasks = Task.where("current_user_id = #{current_user.id}")

    respond_to do |format|
      format.html { render action: "show_qa_analist" }
      format.json { head :ok }
    end
  end

  # Show planner's trays
  def show_planner
    screen_name("Inicial-Planificador")

    @tasks = Task.where("current_user_id = #{current_user.id}")

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
        if ot.current_task.current_user_id == current_user.id
          @ots_incoming << ot
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
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC")

    if current_user.role.id == 3 || current_user.role.id == 5
      @task = @ot.current_task
    end
  end

  # Show document's detail
  def show_document
    screen_name("Mostrar-Documento")

    frbr_manifestation_id = params[:frbr_manifestation_id]
    @document = FrbrManifestation.find(frbr_manifestation_id)
  end

  def choose_document
    ot_id = params[:ot_id]
    @ot = Ot.find(ot_id)

    @frbr_work = FrbrWork.new
    frbr_expression = FrbrExpression.new({ :frbr_document_type_id => 3, :version => 1, :language => 'es' })
    @frbr_work.frbr_expressions << frbr_expression
    frbr_manifestation = FrbrManifestation.new
    frbr_expression.frbr_manifestations << frbr_manifestation
  end

  def create_document
    @ot = Ot.find(params[:ot_id])
    @frbr_work = FrbrWork.new(params[:frbr_work])

    respond_to do |format|
      if @frbr_work.save
        # Associate ot to new manifestation
        @ot.source_frbr_manifestation_id = @frbr_work.frbr_expressions[0].frbr_manifestations[0].id
        @ot.save
        # Bump task to next step

        format.html { redirect_to show_ot(@ot.id), notice: 'Frbr document was successfully created.' }
      else
        format.html { render action: "choose_document" }
      end
    end
  end
end
