class FrbrManifestation < ActiveRecord::Base
  belongs_to :frbr_expression
  has_many :ots
  has_attached_file :document

  validates_attachment_presence :document

  def name
    frbr_expression.name
  end
end
