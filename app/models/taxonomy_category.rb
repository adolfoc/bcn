class TaxonomyCategory < ActiveRecord::Base
  has_many :taxonomy_terms
end
