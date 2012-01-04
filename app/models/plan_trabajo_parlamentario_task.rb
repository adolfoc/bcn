class PlanTrabajoParlamentarioTask < Task
  include Workflow
  workflow do
    state :inicial do
      event :comienza_definir, :transitions_to => :definiendo_parametros
    end
    state :definiendo_parametros do
      event :termina_definir, :transitions_to => :revisando_resultados
    end
    state :modificando_parametros do
      event :termina_modificar, :transitions_to => :revisando_resultados
    end
    state :revisando_resultados do
      event :rechaza_parametros, :transitions_to => :modificando_parametros
      event :acepta_parametros, :transitions_to => :generando_ots
    end
    state :generando_ots do
      event :ots_generadas, :transitions_to => :en_curso
    end
    state :en_curso do
      event :todas_procesadas, :transitions_to => :termina_poblamiento
    end
    state :termina_trabajo_parlamentario
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
    return true if task.to_sym == :termina_trabajo_parlamentario
    false
  end

  def decode_ot_state
    case workflow_state
    when "inicial"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "definiendo_parametros"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "modificando_parametros"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "revisando_resultados"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "generando_ots"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "en_curso"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "termina_trabajo_parlamentario"
      return OtState.find_by_ordinal(OtState::OT_STATE_PUBLICADA).id
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

  def on_termina_modificar_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "termina_modificar")
  end

  def on_rechaza_parametros_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "rechaza_parametros")
  end

  def on_acepta_parametros_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "acepta_parametros")
  end

  def on_ots_generadas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "ots_generadas")
  end

  def on_todas_procesadas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "todas_procesadas")
  end
end
