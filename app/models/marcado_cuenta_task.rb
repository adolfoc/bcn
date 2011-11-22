class MarcadoCuentaTask < Task
  include Workflow
  workflow do
    state :por_asignar do
      event :asignacion, :transitions_to => :asignada
    end
    state :asignada do
      event :comienza_evaluar, :transitions_to => :evaluando_resultados
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

  def is_active?
    return false if workflow_state.to_sym == :por_asignar
    return false if workflow_state.to_sym == :enviada_a_qa
    true
  end

  def initial_task
    :por_asignar
  end

  def final_task?(task)
    return true if task.to_sym == :enviada_a_qa
    false
  end

  def reset_state
    Rails.logger.info("$$$ MarcadoCuentaTask::reset_state")
    params = Hash.new
    params[:workflow_state] = initial_task.to_s
    params[:completed_on] = nil
    update_attributes(params)
  end

  def to_enviada_a_qa
    Rails.logger.info("$$$ MarcadoCuentaTask::to_enviada_a_qa")
    ot = Ot.find(ot_id)
    Rails.logger.info("$$$ MarcadoCuentaTask::to_enviada_a_qa ot = #{ot.inspect}")
    if !ot.nil?
      a = ot.tasks.select { |task| true if task.task_type_id == 5 }
      Rails.logger.info("$$$ MarcadoCuentaTask::to_enviada_a_qa a = #{a.inspect}")
      if a.count > 0
        a.first.reset_state
      end
    end
  end

  # We're transitioning to QA. Reset the QA task and invoke
  def no_requiere_modificaciones
    to_enviada_a_qa
  end

  def termina_correcciones
    to_enviada_a_qa
  end

  # marcado_cuenta/perform_work/:task_id/(:event)
  def controller_action(event = nil)
    return "marcado_cuenta/perform_work/#{id}/#{event}" if !event.nil?
    "marcado_cuenta/perform_work/#{id}"
  end

  # Notifications to clients
  def on_asignada_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "asignada")
  end

  def on_asignada_exit(prior_state, triggering_event, *event_args)
  end

  def on_evaluando_resultados_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evaluando_resultados")
  end

  def on_evaluando_resultados_exit(prior_state, triggering_event, *event_args)
  end

  def on_corrigiendo_manualmente_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "corrigiendo_manualmente")
  end

  def on_corrigiendo_manualmente_exit(prior_state, triggering_event, *event_args)
  end

  def on_en_marcaje_automatico_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "marcaje_automatico")
  end

  def on_en_marcaje_automatico_exit(prior_state, triggering_event, *event_args)
  end

  def on_enviada_a_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "enviada_a_qa")
  end

  def on_enviada_a_qa_exit(prior_state, triggering_event, *event_args)
  end
end

