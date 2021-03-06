class PlanCuentaTask < Task
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
      return false if !completed_on.nil?
  #    return false if final_task?(workflow_state.to_sym)
      true
    end

  def initial_task
    :eligiendo_documento
  end

  def final_task?(task)
    return true if task.to_sym == :notificar_analista
    false
  end

  def decode_ot_state
    case workflow_state
    when "eligiendo_documento"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "asignando_tareas"
      return OtState.find_by_ordinal(OtState::OT_STATE_INICIALIZADA).id
    when "notificar_analista"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    end
  end

  # plan_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_cuenta/perform_work/#{id}/#{event}" if !event.nil?
    "plan_cuenta/perform_work/#{id}"
  end

  # Notifications to clients
  def on_eligiendo_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "eligiendo_documento")
  end

  def on_asignando_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignando_tareas")
  end

  def on_notificar_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificar_analista")
  end
end

