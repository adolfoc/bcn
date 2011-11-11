class HomeController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  def index
    if current_user.nil?
      show_empty
    elsif current_user.role.id == 5
      show_admin
    elsif current_user.role.id == 1
      show_analist
    elsif current_user.role.id == 2
      show_qa_analist
    elsif current_user.role.id == 3
      show_planner
    else
      show_empty
    end
  end

  def show_empty
    respond_to do |format|
      format.html { render action: "show_empty" }
      format.json { head :ok }
    end
  end

  def show_admin
    @ots_incoming = Ot.where("ot_state_id < 3")
    @ots_work = Ot.where("ot_state_id > 2 AND ot_state_id < 6")
    @ots_sent = Ot.where("ot_state_id > 5")
    respond_to do |format|
      format.html { render action: "show_admin" }
      format.json { head :ok }
    end
  end

  def show_analist
    @tasks = Task.where("current_user_id = #{current_user.id}")
    respond_to do |format|
      format.html { render action: "show_analist" }
      format.json { head :ok }
    end
  end

  def show_qa_analist
    @tasks = Task.where("current_user_id = #{current_user.id}")
    respond_to do |format|
      format.html { render action: "show_qa_analist" }
      format.json { head :ok }
    end
  end

  def show_planner
    @ots = Ot.all
    respond_to do |format|
      format.html { render action: "show_planner" }
      format.json { head :ok }
    end
  end

  def show_ot
    ot_id = params[:ot_id]
    @ot = Ot.find(ot_id)
    @log = Audit.where("ot_id = #{@ot.id}").order("created_at DESC")
  end

  def show_document
    frbr_manifestation_id = params[:frbr_manifestation_id]
    @document = FrbrManifestation.find(frbr_manifestation_id)
  end

  def choose_document
    ot_id = params[:ot_id]
    @ot = Ot.find(ot_id)
  end
end
