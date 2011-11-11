class PlanCuentaTask < Task
  include Workflow
  workflow do
    state :eligiendo_documento do
      event :documentos_elegidos, :transitions_to => :asignando_tareas
    end
    state :asignando_tareas do
      event :tareas_asignadas, :transitions_to => :notificar_analista
    end
    state :notificar_analista
  end

  def initial_task
    :eligiendo_documento
  end

  def final_task?(task)
    return true if task.to_sym == :notificar_analista
    false
  end

  def reset_state
    Rails.logger.info("$$$ PlanCuentaTask::reset_state")
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
end

