class PoblamientoParam < ActiveRecord::Base
  belongs_to :ot
  belongs_to :frbr_entity
  belongs_to :frbr_bcn_type
  belongs_to :priority
  belongs_to :intermediary
  belongs_to :location, :class_name => "PoblamientoImportLocation", :foreign_key => :location_id
  belongs_to :file_format, :class_name => "PoblamientoFileFormat", :foreign_key => :file_format_id
end
