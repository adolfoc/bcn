class AmResult < ActiveRecord::Base
  belongs_to :ot
  has_many :am_observations
end
