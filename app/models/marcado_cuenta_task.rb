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
    Rails.logger.info("$$$ MarcadoCuentaTask::final_task(#{task})")
    if task.to_sym == :enviada_a_qa
      true
    else
      false
    end
  end
end

