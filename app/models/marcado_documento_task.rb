class MarcadoDocumentoTask < Task
  include Workflow
  workflow do
    state :por_asignar do
      event :asignacion, :transitions_to => :asignada
    end
    state :asignada do
      event :requiere_marcaje_automatico, :transitions_to => :en_marcaje_automatico
      event :no_requiere_marcaje_automatico, :transitions_to => :evaluando_resultados
    end
    state :evaluando_resultados do
      event :requiere_modificaciones, :transitions_to => :corrigiendo_manualmente
      event :no_requiere_modificaciones, :transitions_to => :enviada_a_qa
    end
    state :corrigiendo_manualmente do
      event :termina_correcciones, :transitions_to => :enviada_a_qa
      event :verifica_correcciones, :transitions_to => :en_marcaje_automatico
    end
    state :en_marcaje_automatico do
      event :termina_marcaje_automatico, :transitions_to => :evaluando_resultados
    end
    state :enviada_a_qa
  end

  def initial_task
    :por_asignar
  end

  def final_task?(task)
    return true if task.to_sym == :enviada_a_qa
    false
  end

  # marcado_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "marcado_documento/perform_work/#{id}/#{event}" if !event.nil?
    "marcado_documento/perform_work/#{id}"
  end

  # Notifications to clients
  def on_por_asignar_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "por_asignar")
  end

  def on_asignada_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignada")
  end

  def on_evaluando_resultados_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evaluando_resultados")
  end

  def on_corrigiendo_manualmente_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "corrigiendo_manualmente")
  end

  def on_en_marcaje_automatico_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "marcaje_automatico")
  end

  def on_enviada_a_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "enviada_a_qa")
  end
end

