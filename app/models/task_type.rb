class TaskType < ActiveRecord::Base
  has_many :tasks
  belongs_to :role

  TASK_TYPE_PLAN_CUENTA_SENATE_MARKUP = 1
  TASK_TYPE_PLAN_CUENTA_HOUSE_MARKUP = 2
  TASK_TYPE_PLAN_RESUMEN_SENATE_MARKUP = 3
  TASK_TYPE_PLAN_RESUMEN_HOUSE_MARKUP = 4
  TASK_TYPE_PLAN_DS_SENATE_MARKUP = 5
  TASK_TYPE_PLAN_DS_HOUSE_MARKUP = 6
  TASK_TYPE_PLAN_CORRECTION = 7

  TASK_TYPE_MARK_CUENTA_SENATE_MARKUP = 10
  TASK_TYPE_MARK_CUENTA_HOUSE_MARKUP = 20
  TASK_TYPE_MARK_RESUMEN_SENATE_MARKUP = 30
  TASK_TYPE_MARK_RESUMEN_HOUSE_MARKUP = 40
  TASK_TYPE_MARK_DS_SENATE_MARKUP = 50
  TASK_TYPE_MARK_DS_HOUSE_MARKUP = 60
  TASK_TYPE_MARK_GENERIC_MARKUP = 70

  TASK_TYPE_VERIFY_CUENTA_SENATE_MARKUP = 100
  TASK_TYPE_VERIFY_CUENTA_HOUSE_MARKUP = 200
  TASK_TYPE_VERIFY_RESUMEN_SENATE_MARKUP = 300
  TASK_TYPE_VERIFY_RESUMEN_HOUSE_MARKUP = 400
  TASK_TYPE_VERIFY_DS_SENATE_MARKUP = 500
  TASK_TYPE_VERIFY_DS_HOUSE_MARKUP = 600
  TASK_TYPE_VERIFY_GENERIC_MARKUP = 700
end
