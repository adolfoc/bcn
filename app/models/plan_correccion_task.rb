class PlanCorreccionTask < Task
  include Workflow
  workflow do
    state :eligiendo_documento do
      event :documentos_elegidos, :transitions_to => :asignando_tareas
    end
    state :asignando_tareas do
      event :tareas_asignadas, :transitions_to => :notificar_analista
    end
    state :notificar_analista
  end

  def is_active?
    return false if workflow_state.to_sym == :eligiendo_documento
    return false if workflow_state.to_sym == :notificar_analista
    true
  end

  def initial_task
    :eligiendo_documento
  end

  def final_task?(task)
    return true if task.to_sym == :notificar_analista
    false
  end

  def reset_state
    Rails.logger.info("$$$ PlanCorreccionTask::reset_state")
    params = Hash.new
    params[:workflow_state] = initial_task.to_s
    params[:completed_on] = nil
    update_attributes(params)
  end

  # We're transitioning to Analist. Reset the Analist task and invoke
  def tareas_asignadas
    ot = Ot.find(ot_id)
    if !ot.nil?
      a = ot.tasks.select { |task| true if task.task_type_id == 1 }
      if a.count > 0
        a.first.reset_state
      end
    end
  end

  # plan_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_correccion/perform_work/#{id}/#{event}" if !event.nil?
    "plan_correccion/perform_work/#{id}"
  end

  # Notifications to clients
  def on_eligiendo_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "eligiendo_documento")
  end

  def on_eligiendo_documento_exit(prior_state, triggering_event, *event_args)
  end

  def on_asignando_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignando_tareas")
  end

  def on_asignando_tareas_exit(prior_state, triggering_event, *event_args)
  end

  def on_notificar_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificar_analista")
  end

  def on_notificar_analista_exit(prior_state, triggering_event, *event_args)
  end
end
