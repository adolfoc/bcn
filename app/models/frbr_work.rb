class FrbrWork < ActiveRecord::Base
  belongs_to :frbr_bcn_type
  belongs_to :frbr_entity
  has_many :frbr_expressions

  accepts_nested_attributes_for :frbr_expressions, :allow_destroy => true

  def name
    frbr_bcn_type.name + " (Sesion #{session.to_s})"
  end
end
