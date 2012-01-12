class Ot < ActiveRecord::Base
  belongs_to :ot_type
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  belongs_to :source_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :source_frbr_manifestation_id
  belongs_to :target_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :target_frbr_manifestation_id
  belongs_to :ot_state
  has_many :tasks
  has_many :audits
  has_many :observations
  has_many :am_results
  has_one :poblamiento_param

  accepts_nested_attributes_for :observations, :allow_destroy => false

  def name
    return ot_type.name + " (#{source_frbr_manifestation.name})" if !source_frbr_manifestation.nil?
    ot_type.name
  end

  def parent_ot
    return nil if parent_ot_id.nil?
    Ot.find(parent_ot_id)
  end

  def close_parent
    if !parent_ot_id.nil?
      if !parent_ot.children_pending?
        parent_ot.mark_complete
      end
    end
  end

  def children
    Ot.where("parent_ot_id = #{id}")
  end

  def children_pending?
    Ot.where("parent_ot_id = #{id}").each do |ot|
      return true if ot.completed_on.nil?
    end
    false
  end

  def mark_read
    if read == false || read == 0
      params = Hash.new
      params[:read] = true
      update_attributes(params)
    end
  end

  def mark_complete
    params = Hash.new
    params[:completed_on] = DateTime.now
    params[:ot_state_id] = OtState.find_by_ordinal(OtState::OT_STATE_PUBLICADA).id
    update_attributes(params)
    close_parent
  end

  def assign_source(manifestation)
    params = Hash.new
    params[:source_frbr_manifestation_id] = manifestation.id
    update_attributes(params)
  end

  def assign_target(manifestation)
    params = Hash.new
    params[:target_frbr_manifestation_id] = manifestation.id
    update_attributes(params)
  end

  def has_been_worked_on_by(user_id)
    tasks.each do |task|
      return true if task.current_user_id == user_id && !task.completed_on.nil?
    end
    false
  end

  def is_multiple_task?
    tasks.count > 3
  end

  def team_members
    team_members = Array.new
    tasks.each do |task|
      if !task.current_user.nil?
        team_member = Hash.new
        team_member[:name] = task.current_user.user_name
        team_member[:role] = task.current_user.role.name
        team_members << team_member
      end
    end

    team_members
  end

  def team_members_as_string
    team_array = team_members
    string = ""
    team_array.each do |member|
      string += ", " if string.length > 0
      string += "#{member[:name]} (#{member[:role]})"
    end
    string
  end

  # Task calls us with task info on every state transition
  def begin_task_execution(task, step)
    params = Hash.new
    params[:current_task_id] = task.id
    params[:current_step] = step

    # if this is a multi-stage ds we don't bother to keep track of individual states
    if is_multiple_task? && get_plan_diario_post_task.nil?
      params[:ot_state_id] = OtState.find_by_ordinal(OtState::OT_STATE_EN_PROCESO).id
    else
      params[:ot_state_id] = task.decode_ot_state
    end
    update_attributes(params)
  end

  def current_task
    return Task.find(current_task_id) if !current_task_id.nil?
    nil
  end

  def current_task_name
    current_task.class.to_s
  end

  def serial_number
    "%05d" % id
  end

  def active_tasks
    active_tasks = Array.new
    tasks.each do |task|
      active_tasks << task if task.is_active?
    end
    active_tasks
  end

  def get_basic_task_params(current_user)
    task_params = Hash.new
    task_params[:created_by] = current_user.id
    task_params[:created_on] = DateTime.now
    task_params[:ot_id] = id
    task_params[:priority_id] = priority_id
    task_params
  end

  def create_plan_marcado_cuenta_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_CUENTA_MARKUP).id
    task_params[:current_user_id] = current_user.id
    plan_cuenta_task = PlanCuentaTask.new(task_params)
    plan_cuenta_task.workflow_state = plan_cuenta_task.initial_task
    plan_cuenta_task.save
    plan_cuenta_task
  end

  def create_marcado_cuenta_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_MARK_GENERIC_MARKUP).id
    marcado_cuenta_task = MarcadoDocumentoTask.new(task_params)
    marcado_cuenta_task.workflow_state = marcado_cuenta_task.initial_task
    marcado_cuenta_task.save
    marcado_cuenta_task
    
  end

  def create_qa_cuenta_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_VERIFY_GENERIC_MARKUP).id
    qa_cuenta_task = QaDocumentoTask.new(task_params)
    qa_cuenta_task.workflow_state = qa_cuenta_task.initial_task
    qa_cuenta_task.save
    qa_cuenta_task
  end

  def create_plan_marcado_diario_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_DS_MARKUP).id
    task_params[:current_user_id] = current_user.id
    plan_diario_task = PlanDiarioTask.new(task_params)
    plan_diario_task.workflow_state = plan_diario_task.initial_task
    plan_diario_task.save
    plan_diario_task
  end

  def create_marcado_diario_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_MARK_GENERIC_MARKUP).id
    marcado_diario_task = MarcadoDocumentoTask.new(task_params)
    marcado_diario_task.workflow_state = marcado_diario_task.initial_task
    marcado_diario_task.save
    marcado_diario_task
  end

  def create_qa_diario_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_VERIFY_GENERIC_MARKUP).id
    qa_diario_task = QaDocumentoTask.new(task_params)
    qa_diario_task.workflow_state = qa_diario_task.initial_task
    qa_diario_task.save
    qa_diario_task
  end

  def create_marcado_cuenta_workflow(current_user)
    first_task = create_plan_marcado_cuenta_task(current_user)
    marcado_task = create_marcado_cuenta_task(current_user)
    qa_task = create_qa_cuenta_task(current_user)

    first_task.successor = marcado_task.id
    marcado_task.predecessor = first_task.id
    marcado_task.successor = qa_task.id
    qa_task.predecessor = marcado_task.id

    first_task
  end

  def create_marcado_diario_workflow(current_user)
    first_task = create_plan_marcado_diario_task(current_user)
    marcado_task = create_marcado_diario_task(current_user)
    qa_task = create_qa_diario_task(current_user)

    first_task.successor = marcado_task.id
    marcado_task.predecessor = first_task.id
    marcado_task.successor = qa_task.id
    qa_task.predecessor = marcado_task.id

    first_task
  end

  def create_plan_correccion_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_CORRECTION).id
    task_params[:current_user_id] = current_user.id
    plan_correccion_task = PlanCorreccionTask.new(task_params)
    plan_correccion_task.workflow_state = plan_correccion_task.initial_task
    plan_correccion_task.save
    plan_correccion_task
  end

  def create_correccion_workflow(current_user)
    first_task = create_plan_correccion_task(current_user)
    marcado_task = create_marcado_cuenta_task(current_user)
    qa_task = create_qa_cuenta_task(current_user)

    first_task.successor = marcado_task.id
    marcado_task.predecessor = first_task.id
    marcado_task.successor = qa_task.id
    qa_task.predecessor = marcado_task.id

    first_task
  end

  def create_plan_poblamiento_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_POBLAMIENTO).id
    task_params[:current_user_id] = current_user.id
    plan_poblamiento_task = PlanPoblamientoTask.new(task_params)
    plan_poblamiento_task.workflow_state = plan_poblamiento_task.initial_task
    plan_poblamiento_task.save
    plan_poblamiento_task
  end

  def create_poblamiento_workflow(current_user)
    first_task = create_plan_poblamiento_task(current_user)

    first_task
  end

  def create_plan_tp_pedido_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_TP_PEDIDO).id
    task_params[:current_user_id] = current_user.id
    plan_trabajo_parlamentario_task = PlanTrabajoParlamentarioTask.new(task_params)
    plan_trabajo_parlamentario_task.workflow_state = plan_trabajo_parlamentario_task.initial_task
    plan_trabajo_parlamentario_task.save
    plan_trabajo_parlamentario_task
  end

  def create_tp_pedido_workflow(current_user)
    first_task = create_plan_tp_pedido_task(current_user)

    first_task
  end

  def create_tasks(current_user)
    if ot_type_id == OtType::OT_TYPE_CUENTA_INPUT
      first_task = create_marcado_cuenta_workflow(current_user)
    elsif ot_type_id == OtType::OT_TYPE_DS_INPUT
      first_task = create_marcado_diario_workflow(current_user)
    elsif ot_type_id == OtType::OT_TYPE_CORRECTION
      first_task = create_correccion_workflow(current_user)
    elsif ot_type_id == OtType::OT_TYPE_HOSTORICAL_DS
      first_task = create_poblamiento_workflow(current_user)
    elsif ot_type_id == OtType::OT_TYPE_TP_ON_DEMAND
      first_task = create_tp_pedido_workflow(current_user)
    end

    begin_task_execution(first_task, first_task.initial_task.to_s) if !first_task.nil?
  end

  def add_markup_diario_tasks(current_user)
    marcado_task = create_marcado_diario_task(current_user)
    qa_task = create_qa_diario_task(current_user)

    marcado_task.successor = qa_task.id
    qa_task.predecessor = marcado_task.id
  end

  def create_plan_diario_post_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = TaskType.find_by_ordinal(TaskType::TASK_TYPE_PLAN_POST_DS_MARKUP).id
    task_params[:current_user_id] = current_user.id
    plan_diario_task = PlanDiarioPostTask.new(task_params)
    plan_diario_task.workflow_state = plan_diario_task.initial_task
    plan_diario_task.save
    plan_diario_task
  end

  def add_markup_diario_post_tasks(current_user)
    plan_diario_post_task = create_plan_diario_post_task(current_user)

    # QA tasks' successor should point to PlanDiarioPostTask
    tasks.each do |task|
      if task.task_type.ordinal == TaskType::TASK_TYPE_VERIFY_GENERIC_MARKUP
        task.successor = plan_diario_post_task.id
      end
    end
  end

  def get_plan_diario_post_task
    tasks.each do |task|
      return task if task.class == PlanDiarioPostTask
    end
    nil
  end

  def add_markup_diario_final_tasks(current_user)
    marcado_task = create_marcado_diario_task(current_user)
    qa_task = create_qa_diario_task(current_user)

    plan_diario_post_task = get_plan_diario_post_task
    plan_diario_post_task.successor = marcado_task.id

    marcado_task.successor = qa_task.id
    qa_task.predecessor = marcado_task.id
  end
end
