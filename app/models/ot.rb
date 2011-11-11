class Ot < ActiveRecord::Base
  belongs_to :ot_type
  belongs_to :owner, :class_name => "User", :foreign_key => :created_by
  belongs_to :priority, :class_name => "Priority", :foreign_key => :priority_id
  belongs_to :source_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :source_frbr_manifestation_id
  belongs_to :target_frbr_manifestation, :class_name => "FrbrManifestation", :foreign_key => :target_frbr_manifestation_id
  belongs_to :ot_state
  has_many :tasks
  has_many :audits

  def name
    ot_type.name
  end
end
