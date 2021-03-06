class OtType < ActiveRecord::Base
  has_many :ot

  OT_TYPE_CUENTA_INPUT    =  1
  OT_TYPE_SUMMARY_INPUT   =  2
  OT_TYPE_DS_INPUT        =  3
  OT_TYPE_CORRECTION      =  4
  OT_TYPE_HOSTORICAL_DS   =  5
  OT_TYPE_TP_ON_DEMAND    =  7
  OT_TYPE_BITACORA_UPDATE =  8
  OT_TYPE_INTEGRATION     =  9
  OT_TYPE_ANTICIPATED_DS  = 10
  OT_TYPE_PARTIAL_DS      = 11
end
