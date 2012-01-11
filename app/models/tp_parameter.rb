class TpParameter < ActiveRecord::Base
  belongs_to :organism, :class_name => "FrbrEntity", :foreign_key => :organism_id
  belongs_to :quality_type
  belongs_to :taxonomy_category
  belongs_to :taxonomy_term
  belongs_to :frbr_bcn_type, :class_name => "FrbrBcnType", :foreign_key => :document_type_id
  belongs_to :debate_type
end
