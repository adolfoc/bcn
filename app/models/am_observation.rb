class AmObservation < ActiveRecord::Base
  belongs_to :am_result
  belongs_to :am_run_observation_type
end
