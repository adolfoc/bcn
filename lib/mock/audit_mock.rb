module AuditMock
  # Log a call to one workflow from another
  def create_log_entry_for_workflow(workflow_from, workflow_to)
    params = Hash.new
    params[:user_id] = current_user.id
    params[:role_id] = current_user.role.id
    params[:ot_id] = @task.ot.id
    params[:task_id] = @task.id
    params[:description] = "Transicion de tarea #{workflow_from} a tarea #{workflow_to}"
    log_entry = Audit.new(params)
    log_entry.save
  end

  # Log a state transition within a workflow
  def create_log_entry
    params = Hash.new
    params[:user_id] = current_user.id
    params[:role_id] = current_user.role.id
    params[:ot_id] = @task.ot.id
    params[:task_id] = @task.id
    params[:description] = "Transicion de #{@task.current_state} a #{@task.current_state.events[@event.to_sym].transitions_to}"
    log_entry = Audit.new(params)
    log_entry.save
  end
end
