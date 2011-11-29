class AmResult < ActiveRecord::Base
  belongs_to :ot
  has_one :am_configuration
  has_many :am_observations
end
