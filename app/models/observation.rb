class Observation < ActiveRecord::Base
  belongs_to :observation_type
  belongs_to :user, :class_name => "User", :foreign_key => :user_id
  belongs_to :ot, :class_name => "Ot", :foreign_key => :ot_id
end
