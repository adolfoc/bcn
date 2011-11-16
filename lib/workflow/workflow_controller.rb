module WorkflowController
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

  def perform_transition
    if !@event.nil?
      create_log_entry
      @task.send(@event.to_s + "!")
    end
  end

  def perform_call_next_task
    next_wf = Task.where("id <> #{@task.id} AND ot_id = #{@task.ot_id}").first
    if !next_wf.nil?
      event = next_wf.current_state.events.first[1].name
      next_wf.send(event.to_s + "!")
    end
  end

  def perform_end_of_task
    if @task.final_task?(@task.workflow_state.to_sym)
      @task.completed_on = DateTime.now
      @task.save

#      perform_call_next_task
    end
  end
end
