class PartiesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.find_all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parties }
    end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    @party = Party.find_by_id(params[:rdf_uri])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @party }
    end
  end

  # GET /parties/new
  # GET /parties/new.json
  def new
    @party = Party.new(Party::RDF_PARTY_NEW_URI, "")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @party }
    end
  end

  # GET /parties/1/edit
  def edit
    @party = Party.find_by_id(params[:rdf_uri])
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(params[:rdf_uri], params[:party_name])

    respond_to do |format|
      if @party.save
        format.html { redirect_to rdf_party_path(@party.id), notice: 'Party was successfully created.' }
        format.json { render json: @party, status: :created, location: @party }
      else
        format.html { render action: "new" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parties/1
  # PUT /parties/1.json
  def update
    @party = Party.find_by_id(params[:rdf_uri])

    respond_to do |format|
      if @party.update_attributes(params)
        format.html { redirect_to rdf_party_path(@party.id), notice: 'Party was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party = Party.find_by_id(params[:rdf_uri])
    @party.destroy

    respond_to do |format|
      format.html { redirect_to parties_url }
      format.json { head :ok }
    end
  end
end
