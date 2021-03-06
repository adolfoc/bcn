class FrbrExpression < ActiveRecord::Base
  belongs_to :frbr_work
  belongs_to :frbr_document_type
  has_many :frbr_manifestations

  accepts_nested_attributes_for :frbr_manifestations, :allow_destroy => true

  validates :version, :language, :presence => true

  def name
    frbr_work.name
  end
end
