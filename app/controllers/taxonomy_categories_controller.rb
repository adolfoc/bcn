class TaxonomyCategoriesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /taxonomy_categories
  # GET /taxonomy_categories.json
  def index
    @taxonomy_categories = TaxonomyCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @taxonomy_categories }
    end
  end

  # GET /taxonomy_categories/1
  # GET /taxonomy_categories/1.json
  def show
    @taxonomy_category = TaxonomyCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taxonomy_category }
    end
  end

  # GET /taxonomy_categories/new
  # GET /taxonomy_categories/new.json
  def new
    @taxonomy_category = TaxonomyCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taxonomy_category }
    end
  end

  # GET /taxonomy_categories/1/edit
  def edit
    @taxonomy_category = TaxonomyCategory.find(params[:id])
  end

  # POST /taxonomy_categories
  # POST /taxonomy_categories.json
  def create
    @taxonomy_category = TaxonomyCategory.new(params[:taxonomy_category])

    respond_to do |format|
      if @taxonomy_category.save
        format.html { redirect_to @taxonomy_category, notice: 'Taxonomy category was successfully created.' }
        format.json { render json: @taxonomy_category, status: :created, location: @taxonomy_category }
      else
        format.html { render action: "new" }
        format.json { render json: @taxonomy_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /taxonomy_categories/1
  # PUT /taxonomy_categories/1.json
  def update
    @taxonomy_category = TaxonomyCategory.find(params[:id])

    respond_to do |format|
      if @taxonomy_category.update_attributes(params[:taxonomy_category])
        format.html { redirect_to @taxonomy_category, notice: 'Taxonomy category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @taxonomy_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxonomy_categories/1
  # DELETE /taxonomy_categories/1.json
  def destroy
    @taxonomy_category = TaxonomyCategory.find(params[:id])
    @taxonomy_category.destroy

    respond_to do |format|
      format.html { redirect_to taxonomy_categories_url }
      format.json { head :ok }
    end
  end
end
