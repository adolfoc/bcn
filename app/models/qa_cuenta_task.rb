class QaCuentaTask < Task
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
    state :guarda_documento
  end

  def initial_task
    :esperando_notificacion_analista
  end

  def final_task?(task)
    if task.to_sym == :devuelve_a_analista || task.to_sym == :devuelve_a_planificador || task.to_sym == :guarda_documento
      true
    else
      false
    end
  end

  def reset_state
    Rails.logger.info("$$$ QaCuentaTask::reset_state")
    params = Hash.new
    params[:workflow_state] = initial_task.to_s
    params[:completed_on] = nil
    update_attributes(params)
  end

  # We're transitioning to Analist. Reset the Analist task and invoke
  def to_devuelve_a_analista
    Rails.logger.info("$$$ QaCuentaTask::to_devuelve_a_analista")
    ot = Ot.find(ot_id)
    Rails.logger.info("$$$ QaCuentaTask::to_devuelve_a_analista ot = #{ot.inspect}")
    if !ot.nil?
      a = ot.tasks.select { |task| true if task.task_type_id == 1 }
      Rails.logger.info("$$$ QaCuentaTask::to_devuelve_a_analista a = #{a.inspect}")
      if a.count > 0
        a.first.reset_state
      end
    end
  end

  def rechaza
    to_devuelve_a_analista
  end

  # Notifications to clients
  def on_esperando_notificacion_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "esperando_notificacion_analista")
  end

  def on_esperando_notificacion_analista_exit(prior_state, triggering_event, *event_args)
  end

  def on_por_validar_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "por_validar_qa")
  end

  def on_por_validar_qa_exit(prior_state, triggering_event, *event_args)
  end

  def on_evalua_qa_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "evalua_qa")
  end

  def on_evalua_qa_exit(prior_state, triggering_event, *event_args)
  end

  def on_devuelve_a_analista_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "devuelve_a_analista")
  end

  def on_devuelve_a_analista_exit(prior_state, triggering_event, *event_args)
  end

  def on_devuelve_a_planificador_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "devuelve_a_planificador")
  end

  def on_devuelve_a_planificador_exit(prior_state, triggering_event, *event_args)
  end

  def on_guarda_documento_entry(prior_state, triggering_event, *event_args)
    ot.begin_task_execution(self, "guarda_documento")
  end

  def on_guarda_documento_exit(prior_state, triggering_event, *event_args)
  end
end

