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
      event :no_hay_errores, :transitions_to => :notificar_qa
      event :hay_errores, :transitions_to => :planifica_asignar_tareas
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
    state :notificar_qa
    state :notificar_equipos
  end

  def is_active?
    return false if workflow_state.to_sym == :eligiendo_documento
    return false if workflow_state.to_sym == :notificar_qa || workflow_state.to_sym == :notificar_equipos
    true
  end

  def initial_task
    :eligiendo_documento
  end

  def final_task?(task)
    return true if task.to_sym == :notificar_qa || task.to_sym == :notificar_equipos
    false
  end

  def reset_state
    Rails.logger.info("$$$ PlanDiarioTask::reset_state")
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
    return "plan_diario/perform_work/#{id}/#{event}" if !event.nil?
    "plan_diario/perform_work/#{id}"
  end

  # Notifications to clients
  def on_eligiendo_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "eligiendo_documento")
  end

  def on_eligiendo_documento_exit(prior_state, triggering_event, *event_args)
  end

  def on_en_marcaje_automatico_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "en_marcaje_automatico")
  end

  def on_en_marcaje_automatico_exit(prior_state, triggering_event, *event_args)
  end

  def on_evaluando_resultados_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evaluando_resultados")
  end

  def on_evaluando_resultados_exit(prior_state, triggering_event, *event_args)
  end

  def on_planifica_asignar_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "planifica_asignar_tareas")
  end

  def on_planifica_asignar_tareas_exit(prior_state, triggering_event, *event_args)
  end

  def on_dividir_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "dividir_tareas")
  end

  def on_dividir_tareas_exit(prior_state, triggering_event, *event_args)
  end

  def on_asignando_tareas_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignando_tareas")
  end

  def on_asignando_tareas_exit(prior_state, triggering_event, *event_args)
  end

  def on_notificar_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificar_qa")
  end

  def on_notificar_qa_exit(prior_state, triggering_event, *event_args)
  end

  def on_notificar_equipos_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "notificar_equipos")
  end

  def on_notificar_equipos_exit(prior_state, triggering_event, *event_args)
  end
end

