class FrbrWork < ActiveRecord::Base
  belongs_to :frbr_bcn_type
  belongs_to :frbr_entity
  has_many :frbr_expressions

  def name
    frbr_bcn_type.name + " (Sesion #{session.to_s})"
  end
end
