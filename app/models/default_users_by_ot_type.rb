class DefaultUsersByOtType < ActiveRecord::Base
  belongs_to :ot_type
  belongs_to :role
  belongs_to :user
end
