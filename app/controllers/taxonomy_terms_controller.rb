class TaxonomyTermsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /taxonomy_terms
  # GET /taxonomy_terms.json
  def index
    @taxonomy_terms = TaxonomyTerm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @taxonomy_terms }
    end
  end

  # GET /taxonomy_terms/1
  # GET /taxonomy_terms/1.json
  def show
    @taxonomy_term = TaxonomyTerm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taxonomy_term }
    end
  end

  # GET /taxonomy_terms/new
  # GET /taxonomy_terms/new.json
  def new
    @taxonomy_term = TaxonomyTerm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taxonomy_term }
    end
  end

  # GET /taxonomy_terms/1/edit
  def edit
    @taxonomy_term = TaxonomyTerm.find(params[:id])
  end

  # POST /taxonomy_terms
  # POST /taxonomy_terms.json
  def create
    @taxonomy_term = TaxonomyTerm.new(params[:taxonomy_term])

    respond_to do |format|
      if @taxonomy_term.save
        format.html { redirect_to @taxonomy_term, notice: 'Taxonomy term was successfully created.' }
        format.json { render json: @taxonomy_term, status: :created, location: @taxonomy_term }
      else
        format.html { render action: "new" }
        format.json { render json: @taxonomy_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /taxonomy_terms/1
  # PUT /taxonomy_terms/1.json
  def update
    @taxonomy_term = TaxonomyTerm.find(params[:id])

    respond_to do |format|
      if @taxonomy_term.update_attributes(params[:taxonomy_term])
        format.html { redirect_to @taxonomy_term, notice: 'Taxonomy term was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @taxonomy_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxonomy_terms/1
  # DELETE /taxonomy_terms/1.json
  def destroy
    @taxonomy_term = TaxonomyTerm.find(params[:id])
    @taxonomy_term.destroy

    respond_to do |format|
      format.html { redirect_to taxonomy_terms_url }
      format.json { head :ok }
    end
  end
end
