class PlanPoblamientoTask < Task
  include Workflow
  workflow do
    state :determina_periodo do
      event :periodo_determinado, :transitions_to => :revisando_parametros
    end
    state :revisando_parametros do
      event :aceptar_parametros, :transitions_to => :genera_ots
      event :rechazar_parametros, :transitions_to => :modificar_periodo
    end
    state :modificar_periodo do
      event :periodo_modificado, :transitions_to => :revisando_parametros
    end
    state :genera_ots do
      event :ots_generadas, :transitions_to => :en_curso
    end
    state :en_curso do
      event :todas_procesadas, :transitions_to => :termina_poblamiento
    end
    state :termina_poblamiento
  end

  def is_active?
    return false if !completed_on.nil?
#    return false if workflow_state.to_sym == initial_task
    return false if final_task?(workflow_state.to_sym)
    true
  end

  def initial_task
    :determina_periodo
  end

  def final_task?(task)
    return true if task.to_sym == :termina_poblamiento
    false
  end

  def decode_ot_state
    case workflow_state
    when "determina_periodo"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "revisando_parametros"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "modificar_periodo"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "genera_ots"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "en_curso"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "termina_poblamiento"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    end
  end

  # plan_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_poblamiento/perform_work/#{id}/#{event}" if !event.nil?
    "plan_poblamiento/perform_work/#{id}"
  end

  # Notifications to clients
  def on_determina_periodo_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "determina_periodo")
  end

  def on_revisando_parametros_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "revisando_parametros")
  end

  def on_modificar_periodo_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "modificar_periodo")
  end

  def on_genera_ots_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "genera_ots")
  end

  def on_termina_poblamiento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "termina_poblamiento")
  end
end
