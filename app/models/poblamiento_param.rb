class PoblamientoParam < ActiveRecord::Base
  belongs_to :ot
  belongs_to :frbr_entity
  belongs_to :frbr_bcn_type
  belongs_to :priority
end
