class Audit < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :ot
  belongs_to :task
end
