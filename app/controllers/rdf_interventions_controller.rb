class RdfInterventionsController < ApplicationController
  require 'will_paginate/array'
  RESULTS_PER_PAGE = 20

  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /rdf_interventions
  # GET /rdf_interventions.json
  def index
    page = params[:page]
    page = 1 if page.nil? || page == 0
    offset = (Integer(page) - 1) * RESULTS_PER_PAGE
    offset = offset + 1 if Integer(page) > 1
    @rdf_interventions = RdfIntervention.find_all(true, RESULTS_PER_PAGE, offset)
    @paginated_rdf_interventions = @rdf_interventions.paginate(:page => page, :per_page => RESULTS_PER_PAGE, :total_entries => RdfIntervention.count)



#    limit = 20
#    offset = 0
#    @rdf_interventions = RdfIntervention.find_all(false, limit, offset)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rdf_interventions }
    end
  end

  # GET /rdf_interventions/1
  # GET /rdf_interventions/1.json
  def show
    @rdf_intervention = RdfIntervention.find_by_id(params[:rdf_uri])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rdf_intervention }
    end
  end

  # GET /rdf_interventions/1/edit
  def edit
    @rdf_intervention = RdfIntervention.find_by_id(params[:rdf_uri])
  end

  # PUT /rdf_interventions/1
  # PUT /rdf_interventions/1.json
  def update
    @rdf_intervention = RdfIntervention.find_by_id(params[:rdf_uri])

    respond_to do |format|
      if @rdf_intervention.update_attributes(params)
        format.html { redirect_to rdf_intervention_path(@party.id), notice: 'Intervention was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rdf_intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rdf_interventions/1
  # DELETE /rdf_interventions/1.json
  def destroy
    @rdf_intervention = RdfIntervention.find_by_id(params[:rdf_uri])
    @rdf_intervention.destroy

    respond_to do |format|
      format.html { redirect_to rdf_interventions_url }
      format.json { head :ok }
    end
  end
end
