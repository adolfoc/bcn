class Role < ActiveRecord::Base
  has_many :users
  has_many :task_types
end
