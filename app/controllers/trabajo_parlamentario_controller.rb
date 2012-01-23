class TrabajoParlamentarioController < ApplicationController
  before_filter :set_menu_section
  respond_to :html, :js, :json

  ##########################################################
  # Helpers
  ##########################################################
  def set_menu_section
    @accordion_section = 6
  end

  def index
  end

  def create
    @parlamentarian_name = "Todos"
    @parlamentarian = nil
    unless params[:persona_id].nil? || params[:persona_id].length == 0
      @parlamentarian = Parlamentarian.find_by_id(params[:persona_id])
      @parlamentarian_name = @parlamentarian.parlamentarian_name
    end

    if @parlamentarian.nil?
      @rdf_interventions = RdfIntervention.find_all(true, RdfIntervention.count, 0)
    else
      @rdf_interventions = RdfIntervention.find_all_person(@parlamentarian.rdf_uri.to_s, RdfIntervention.count_person(@parlamentarian.rdf_uri.to_s), 0)
    end

    respond_with @rdf_interventions
  end
end
