class ObservationType < ActiveRecord::Base
  has_many :observations

  OBS_TYPE_OBSERVATION = 10
  OBS_TYPE_INSTRUCTION = 20
  OBS_TYPE_WARNING = 30
  OBS_TYPE_OTHER = 40
end
