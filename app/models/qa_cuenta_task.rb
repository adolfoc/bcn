class QaCuentaTask < Task
  include Workflow
  workflow do
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
    :por_validar_qa
  end
end

