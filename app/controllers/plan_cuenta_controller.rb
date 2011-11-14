require 'workflow_controller'

class PlanCuentaController < ApplicationController
  include WorkflowController

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 0
  end

  def perform_work
    @task = Task.find(params[:task_id])
    @event = params[:event]

    perform_transition
    perform_end_of_task

    respond_to do |format|
      format.html { render action: "perform_work" }
      format.json { head :ok }
    end
  end
end
