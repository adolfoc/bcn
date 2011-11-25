class AmRunObservationType < ActiveRecord::Base
  has_many :am_observations

  AM_OBSERVATION_TYPE_ADVERTENCIA = 1
  AM_OBSERVATION_TYPE_OBSERVACION = 2
  AM_OBSERVATION_TYPE_ERROR = 3
end
