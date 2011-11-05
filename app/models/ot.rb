class Ot < ActiveRecord::Base
  belongs_to :ot_type
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  has_many :tasks
end
