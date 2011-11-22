class PlanDiarioController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  def perform_work
    @task = Task.find(params[:task_id])
    @ot = Ot.find(@task.ot_id)
    @ot.mark_read

    case @task.workflow_state
    when "eligiendo_documento"
      eligiendo_documento
    when "asignando_tareas"
      asignando_tareas
    when "notificar_analista"
      notificar_analista
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

  def asignando_tareas
    screen_name("#{@task.class.to_s}/asignando_tareas")

    @tasks = []
    @ot.tasks.each do |task|
      @tasks << task if task.id != @task.id
    end

    respond_to do |format|
      format.html { render action: "asignando_tareas" }
      format.json { head :ok }
    end
  end

  def notificar_analista
    screen_name("#{@task.class.to_s}/notificar_analista")

    respond_to do |format|
      format.html { render action: "notificar_analista" }
      format.json { head :ok }
    end
  end

end
