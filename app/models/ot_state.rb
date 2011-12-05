class OtState < ActiveRecord::Base
  has_many :ots

  OT_STATE_POR_INICIAR = 10
  OT_STATE_INICIALIZADA = 20
  OT_STATE_POR_ASIGNAR = 30
  OT_STATE_EN_PROCESO = 40
  OT_STATE_POR_PUBLICAR = 50
  OT_STATE_PUBLICADA = 60
  OT_STATE_ELIMINADA = 70
end
