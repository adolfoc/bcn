class DocTypeAmConfiguration < ActiveRecord::Base
  belongs_to :frbr_bcn_type, :class_name => "FrbrBcnType", :foreign_key => :frbr_bcn_id
end
