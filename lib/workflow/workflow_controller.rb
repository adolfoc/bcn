module WorkflowController
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

  def create_source_document_template
    frbr_work = FrbrWork.new
    
    frbr_expression = FrbrExpression.new({ :frbr_document_type_id => 3, :version => 1, :language => 'es' })
    frbr_work.frbr_expressions << frbr_expression
    
    frbr_manifestation = FrbrManifestation.new
    frbr_expression.frbr_manifestations << frbr_manifestation

    frbr_work
  end

  def get_dummy_text
    frbr_manifestation = FrbrManifestation.find(@ot.target_frbr_manifestation_id)
    File.open("#{Rails.root.to_s}/public/system/documents/#{frbr_manifestation.id.to_s}/original/#{frbr_manifestation.document_file_name}", 'r') { |f| f.read }
  end

  def create_random_am_warning(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_ADVERTENCIA
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es una advertencia del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end

  def create_random_am_observation(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_OBSERVACION
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es una observacion del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end

  def create_random_am_error(am_result_id)
    obs_params = Hash.new
    obs_params[:am_result_id] = am_result_id
    obs_params[:am_run_observation_type_id] = AmRunObservationType::AM_OBSERVATION_TYPE_ERROR
    obs_params[:line] = (Random.new.rand * 1000).to_i
    obs_params[:contents] = "Este es un error del marcaje automatico"
    obs = AmObservation.new(obs_params)
    obs.save
    obs
  end

  def mock_up_am_results
    params = Hash.new
    params[:run_date] = DateTime.now
    params[:ot_id] = @ot.id
    am_result = AmResult.new(params)
    am_result.save

    create_random_am_warning(am_result.id)
    create_random_am_observation(am_result.id)
    create_random_am_error(am_result.id)
  end

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
  def call_next_workflow(next_task)
    next_task.reset_state

    # update ot
    ot_params = Hash.new
    ot_params[:current_task_id] = next_task.id
    ot_params[:current_step] = next_task.initial_task.to_s
    @ot.update_attributes(ot_params)

    # mark current task complete
    @task.mark_complete

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
