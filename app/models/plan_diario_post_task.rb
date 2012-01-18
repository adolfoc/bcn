class PlanDiarioPostTask < Task
  include Workflow
  workflow do
    state :esperando_notificacion_analista do
      event :recibe_notificacion_analista, :transitions_to => :verificando_completitud
    end
    state :verificando_completitud do
      event :trabajo_completo, :transitions_to => :revisando_documento_completo
      event :trabajo_incompleto, :transitions_to => :esperando_notificacion_analista
    end
    state :revisando_documento_completo do
      event :evalua_trabajo_terminado, :transitions_to => :publicando_diario_de_sesiones
      event :evalua_trabajo_incompleto, :transitions_to => :asignando_tareas
    end
    state :asignando_tareas do
      event :tareas_asignadas, :transitions_to => :notificando_equipos
    end
    state :publicando_diario_de_sesiones do
      event :tripletas_generadas, :transitions_to => :diario_publicado
    end
    state :diario_publicado
    state :notificando_equipos
  end

  def initial_task
    :esperando_notificacion_analista
  end

  def final_task?(task)
    return true if task.to_sym == :diario_publicado || task.to_sym == :notificar_equipos
    false
  end

  def decode_ot_state
    case workflow_state
    when "esperando_notificacion_analista"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "verificando_completitud"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "revisando_documento_completo"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "asignando_tareas"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_ASIGNAR).id
    when "publicando_diario_de_sesiones"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_PUBLICAR).id
    when "diario_publicado"
      return OtState.find_by_ordinal(OtState::OT_STATE_PUBLICADA).id
    when "notificando_equipos"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    end
  end

  # plan_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_diario_post/perform_work/#{id}/#{event}" if !event.nil?
    "plan_diario_post/perform_work/#{id}"
  end

  # Notifications to clients
  def on_esperando_notificacion_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "esperando_notificacion_analista")
  end

  def on_verificando_completitud_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "verificando_completitud")
  end

  def on_revisando_documento_completo_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "revisando_documento_completo")
  end

  def on_asignando_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignando_tareas")
  end

  def on_publicando_diario_de_sesiones_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "publicando_diario_de_sesiones")
  end

  def on_notificando_equipos_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificando_equipos")
  end
end
