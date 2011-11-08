class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  belongs_to :ot
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :current_user, :class_name => "User", :foreign_key => :current_user_id
  has_many :audits

  def name
    task_type.name
  end
end
