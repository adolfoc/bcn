class MarcadoCuentaController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  def perform_work
    @task = Task.find(params[:task_id])
    if @task.workflow_state.to_sym == @task.final_task
      @task.completed_on = DateTime.now
      @task.save
    end

    respond_to do |format|
      format.html { render action: "perform_work" }
      format.json { head :ok }
    end
  end

  def comienza_evaluar
    @task = Task.find(params[:task_id])
    @task.comienza_evaluar!
    perform_work
  end

  def requiere_modificaciones
    @task = Task.find(params[:task_id])
    @task.requiere_modificaciones!
    perform_work
  end

  def no_requiere_modificaciones
    @task = Task.find(params[:task_id])
    @task.no_requiere_modificaciones!
    perform_work
  end

  def termina_correcciones
    @task = Task.find(params[:task_id])
    @task.termina_correcciones!
    perform_work
  end

  def verifica_correcciones
    @task = Task.find(params[:task_id])
    @task.verifica_correcciones!
    perform_work
  end

  def termina_marcaje_automatico
    @task = Task.find(params[:task_id])
    @task.termina_marcaje_automatico!
    perform_work
  end
end
