class PlanDiarioTask < Task
  include Workflow
  workflow do
    state :eligiendo_documento do
      event :documentos_elegidos, :transitions_to => :en_marcaje_automatico
    end
    state :en_marcaje_automatico do
      event :termina_marcaje_automatico, :transitions_to => :evaluando_resultados
    end
    state :evaluando_resultados do
      event :termina_evaluacion, :transitions_to => :planifica_asignar_tareas
    end
    state :planifica_asignar_tareas do
      event :decide_dividir, :transitions_to => :dividir_tareas
      event :decide_no_dividir, :transitions_to => :asignando_tareas
    end
    state :dividir_tareas do
      event :tareas_divididas, :transitions_to => :notificar_equipos
    end
    state :asignando_tareas do
      event :tareas_asignadas, :transitions_to => :notificar_equipos
    end
    state :notificar_equipos
  end

  def initial_task
    :eligiendo_documento
  end

  def final_task?(task)
    return true if task.to_sym == :notificar_qa || task.to_sym == :notificar_equipos
    false
  end

  # plan_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "plan_diario/perform_work/#{id}/#{event}" if !event.nil?
    "plan_diario/perform_work/#{id}"
  end

  # Notifications to clients
  def on_eligiendo_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "eligiendo_documento")
  end

  def on_en_marcaje_automatico_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "en_marcaje_automatico")
  end

  def on_evaluando_resultados_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evaluando_resultados")
  end

  def on_planifica_asignar_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "planifica_asignar_tareas")
  end

  def on_dividir_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "dividir_tareas")
  end

  def on_asignando_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignando_tareas")
  end

  def on_notificar_equipos_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificar_equipos")
  end
end

