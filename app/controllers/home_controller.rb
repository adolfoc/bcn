class HomeController < ApplicationController
  def index
    @ots = Ot.all
  end

  def show_ot
    ot_id = params[:ot_id]
    @ot = Ot.find(ot_id)
  end

  def show_document
    frbr_manifestation_id = params[:frbr_manifestation_id]
    @document = FrbrManifestation.find(frbr_manifestation_id)
  end
end
