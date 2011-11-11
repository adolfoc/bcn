class MarcadoCuentaTask < Task
  include Workflow
  workflow do
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

  def initial_task
    :asignada
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
end

