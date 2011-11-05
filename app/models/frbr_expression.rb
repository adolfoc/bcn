class FrbrExpression < ActiveRecord::Base
  belongs_to :frbr_work
  belongs_to :frbr_document_type
  has_many :frbr_manifestations

  def name
    frbr_work.name + " (#{frbr_document_type.name})"
  end
end
