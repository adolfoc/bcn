class Task < ActiveRecord::Base
  belongs_to :task_type, :class_name => "TaskType", :foreign_key => :task_type_id
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  belongs_to :ot
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :current_user, :class_name => "User", :foreign_key => :current_user_id
  has_many :audits

  def name
    task_type.name
  end

  def state
    "Indefinido"
  end
  
  def initial_task
  end

  def is_active?
    return false if workflow_state.to_sym == initial_task
    return false if final_task?(workflow_state.to_sym)
    true
  end

  def predecessor
    return nil if predecessor_id.nil?
    Task.find(predecessor_id)
  end

  def predecessor=(pred_id)
    params = Hash.new
    params[:predecessor_id] = pred_id
    update_attributes(params)
  end

  def successor
    return nil if successor_id.nil?
    Task.find(successor_id)
  end

  def successor=(succ_id)
    params = Hash.new
    params[:successor_id] = succ_id
    update_attributes(params)
  end

  def workflow_name
    self.class.to_s
  end

  def mark_complete
    task_params = Hash.new
    task_params[:completed_on] = DateTime.now
    update_attributes(task_params)
  end

  def reset_state
    params = Hash.new
    params[:workflow_state] = initial_task.to_s
    params[:completed_on] = nil
    update_attributes(params)
  end
end
