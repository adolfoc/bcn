class QaDocumentoTask < Task
  include Workflow
  workflow do
    state :esperando_notificacion_analista do
      event :recibe_notificacion, :transitions_to => :por_validar_qa
    end
    state :por_validar_qa do
      event :comienza_validar, :transitions_to => :evalua_qa
    end
    state :evalua_qa do
      event :rechaza, :transitions_to => :devuelve_a_analista
      event :aprueba_tarea, :transitions_to => :devuelve_a_planificador
      event :aprueba_ot, :transitions_to => :guarda_documento
    end
    state :devuelve_a_analista
    state :devuelve_a_planificador
    state :guarda_documento do
      event :publica_documento, :transitions_to => :documento_publicado
    end
    state :documento_publicado
  end

  def initial_task
    :esperando_notificacion_analista
  end

  def final_task?(task)
    if task.to_sym == :devuelve_a_analista || task.to_sym == :devuelve_a_planificador || task.to_sym == :documento_publicado
      true
    else
      false
    end
  end

  def decode_ot_state
    case workflow_state
    when "esperando_notificacion_analista"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_INICIAR).id
    when "por_validar_qa"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "evalua_qa"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "devuelve_a_analista"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "devuelve_a_planificador"
      return OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    when "guarda_documento"
      return OtState.find_by_ordinal(OtState::OT_STATE_POR_PUBLICAR).id
    when "documento_publicado"
      return OtState.find_by_ordinal(OtState::OT_STATE_PUBLICADA).id
    end
  end

  # qa_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "qa_documento/perform_work/#{id}/#{event}" if !event.nil?
    "qa_documento/perform_work/#{id}"
  end

  # Notifications to clients
  def on_esperando_notificacion_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "esperando_notificacion_analista")
  end

  def on_por_validar_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "por_validar_qa")
  end

  def on_evalua_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evalua_qa")
  end

  def on_devuelve_a_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "devuelve_a_analista")
  end

  def on_devuelve_a_planificador_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "devuelve_a_planificador")
  end

  def on_guarda_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "guarda_documento")
  end

  def on_documento_publicado_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "documento_publicado")
  end
end

