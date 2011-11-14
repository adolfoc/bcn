class Ot < ActiveRecord::Base
  belongs_to :ot_type
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  belongs_to :source_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :source_frbr_manifestation_id
  belongs_to :target_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :target_frbr_manifestation_id
  belongs_to :ot_state
  has_many :tasks
  has_many :audits

  def name
    ot_type.name
  end

  # Task calls us with task info on every state transition
  def begin_task_execution(task, step)
    params = Hash.new
    params[:current_task_id] = task.id
    params[:current_step] = step
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
    task_params[:task_type_id] = 4
    task_params[:current_user_id] = current_user.id
    plan_cuenta_task = PlanCuentaTask.new(task_params)
    plan_cuenta_task.workflow_state = plan_cuenta_task.initial_task
    plan_cuenta_task.save
    plan_cuenta_task
  end

  def create_marcado_cuenta_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = 1
    marcado_cuenta_task = MarcadoCuentaTask.new(task_params)
    marcado_cuenta_task.workflow_state = marcado_cuenta_task.initial_task
    marcado_cuenta_task.save
    marcado_cuenta_task
    
  end

  def create_qa_cuenta_task(current_user)
    task_params = get_basic_task_params(current_user)
    task_params[:task_type_id] = 5
    qa_cuenta_task = QaCuentaTask.new(task_params)
    qa_cuenta_task.workflow_state = qa_cuenta_task.initial_task
    qa_cuenta_task.save
    qa_cuenta_task
  end

  def create_tasks(current_user)
    if ot_type_id == 1
      first_task = create_plan_marcado_cuenta_task(current_user)
      create_marcado_cuenta_task(current_user)
      create_qa_cuenta_task(current_user)
    end

    begin_task_execution(first_task, first_task.initial_task.to_s) if !first_task.nil?
  end
end
