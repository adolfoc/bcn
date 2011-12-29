class PlanTrabajoParlamentarioTask < Task
  include Workflow
  workflow do
    state :inicial do
      event :comienza_definir, :transitions_to => :definiendo_parametros
    end
    state :definiendo_parametros do
      event :termina_definir, :transitions_to => :revisando_resultados
    end
    state :revisando_resultados do
      event :rechaza_parametros, :transitions_to => :definiendo_parametros
      event :acepta_parametros, :transitions_to => :generando_modelo
    end
    state :generando_modelo do
      event :rechaza_modelo, :transitions_to => :definiendo_parametros
      event :acepta_modelo, :transitions_to => :generando_ots
    end
    state :generando_ots
  end

  def is_active?
    return false if !completed_on.nil?
#    return false if workflow_state.to_sym == initial_task
    return false if final_task?(workflow_state.to_sym)
    true
  end

  def initial_task
    :inicial
  end

  def final_task?(task)
    return true if task.to_sym == :generando_ots
    false
  end

  def decode_ot_state
    case workflow_state
    when "inicial"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "definiendo_parametros"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "revisando_resultados"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "generando_modelo"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "generando_ots"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    end
  end

  # plan_trabajo_parlamentario/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_trabajo_parlamentario/perform_work/#{id}/#{event}" if !event.nil?
    "plan_trabajo_parlamentario/perform_work/#{id}"
  end

  # Notifications to clients
  def on_comienza_definir_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "comienza_definir")
  end

  def on_termina_definir_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "termina_definir")
  end

  def on_rechaza_parametros_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "rechaza_parametros")
  end

  def on_acepta_parametros_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "acepta_parametros")
  end

  def on_rechaza_modelo_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "rechaza_modelo")
  end

  def on_acepta_modelo_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "acepta_modelo")
  end
end
