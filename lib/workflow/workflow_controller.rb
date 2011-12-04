require 'audit_mock'
require 'am_result_mock'
require 'am_configuration_mock'
require 'am_mock'
require 'target_document_version_mock'
require 'document_mock'

module WorkflowController
  include AuditMock
  include AmResultMock
  include AmConfigurationMock
  include AmMock
  include TargetDocumentVersionMock
  include DocumentMock

  # Perform a state transition
  def do_perform_transition(event)
    @event = event
    create_log_entry
    @task.send(@event.to_s + "!")

    # Refresh task and ot with new state
    @task = Task.find(@task.id)
    @ot = Ot.find(@task.ot_id)
  end

  # Update completed task, ot with new workflow information, log transition
  def call_next_workflow(next_task, mark_current_complete = true)
    next_task.reset_state

    # update ot
    ot_params = Hash.new
    ot_params[:current_task_id] = next_task.id
    ot_params[:current_step] = next_task.initial_task.to_s
    @ot.update_attributes(ot_params)

    # mark current task complete
    @task.mark_complete if mark_current_complete

    # log the transition
    create_log_entry_for_workflow(@task.name, next_task.name)
  end

  # Deprecated
  def perform_call_next_task
    next_wf = Task.where("id <> #{@task.id} AND ot_id = #{@task.ot_id}").first
    if !next_wf.nil?
      event = next_wf.current_state.events.first[1].name
      next_wf.send(event.to_s + "!")
    end
  end

  # Deprecated
  def perform_end_of_task
    if @task.final_task?(@task.workflow_state.to_sym)
      @task.completed_on = DateTime.now
      @task.save

#      perform_call_next_task
    end
  end
end
