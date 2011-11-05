class TaskType < ActiveRecord::Base
  has_many :tasks
  belongs_to :role
end
