class FrbrWork < ActiveRecord::Base
  belongs_to :frbr_bcn_type
  belongs_to :frbr_entity
  belongs_to :delivery_method
  belongs_to :intermediary
  has_many :frbr_expressions

  accepts_nested_attributes_for :frbr_expressions, :allow_destroy => true

  validates :frbr_bcn_type_id, :frbr_entity_id, :session, :legislature, :presence => true

  def name
    frbr_bcn_type.name + " (Sesion #{session.to_s}, Legislatura #{legislature.to_s})"
  end
end
