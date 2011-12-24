class ParticipationTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /participation_types
  # GET /participation_types.json
  def index
    @participation_types = ParticipationType.find_all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @participation_types }
    end
  end

  # GET /participation_types/1
  # GET /participation_types/1.json
  def show
    @participation_type = ParticipationType.find_by_id(params[:rdf_uri])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participation_type }
    end
  end

  # GET /participation_types/new
  # GET /participation_types/new.json
  def new
    @participation_type = ParticipationType.new(ParticipationType::RDF_PARTICIPATION_TYPE_NEW_URI, "")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participation_type }
    end
  end

  # GET /participation_types/1/edit
  def edit
    @participation_type = ParticipationType.find_by_id(params[:rdf_uri])
  end

  # POST /participation_types
  # POST /participation_types.json
  def create
    @participation_type = ParticipationType.new(params[:rdf_uri], params[:participation_type_name])

    respond_to do |format|
      if @participation_type.save
        format.html { redirect_to rdf_participation_type_path(@participation_type.id), notice: 'Participation type was successfully created.' }
        format.json { render json: @participation_type, status: :created, location: @participation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @participation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participation_types/1
  # PUT /participation_types/1.json
  def update
    @participation_type = ParticipationType.find_by_id(params[:rdf_uri])

    respond_to do |format|
      if @participation_type.update_attributes(params[:participation_type])
        format.html { redirect_to @participation_type, notice: 'Participation type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @participation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participation_types/1
  # DELETE /participation_types/1.json
  def destroy
    @participation_type = ParticipationType.find_by_id(params[:rdf_uri])
    @participation_type.destroy

    respond_to do |format|
      format.html { redirect_to participation_types_url }
      format.json { head :ok }
    end
  end
end
