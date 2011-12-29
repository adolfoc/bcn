class TaxonomyTerm < ActiveRecord::Base
  belongs_to :taxonomy_category
end
