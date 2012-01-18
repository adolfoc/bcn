class Bitacora < ActiveRecord::Base
  belongs_to :tramite_constitucional
  belongs_to :tramite_normativo
  belongs_to :user
end
