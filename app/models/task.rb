class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :ot
end
