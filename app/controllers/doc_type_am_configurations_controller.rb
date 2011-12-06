class DocTypeAmConfigurationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /doc_type_am_configurations
  # GET /doc_type_am_configurations.json
  def index
    @doc_type_am_configurations = DocTypeAmConfiguration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @doc_type_am_configurations }
    end
  end

  # GET /doc_type_am_configurations/1
  # GET /doc_type_am_configurations/1.json
  def show
    @doc_type_am_configuration = DocTypeAmConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doc_type_am_configuration }
    end
  end

  # GET /doc_type_am_configurations/new
  # GET /doc_type_am_configurations/new.json
  def new
    @doc_type_am_configuration = DocTypeAmConfiguration.new

    @doc_type_am_configuration.structural_markup_enabled = true
    @doc_type_am_configuration.structural_markup_extension_whole_document = true
    @doc_type_am_configuration.structural_markup_depth_all = true
    @doc_type_am_configuration.semantic_markup_enabled = true
    @doc_type_am_configuration.semantic_markup_extension_whole_document = true
    @doc_type_am_configuration.semantic_markup_depth_all = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doc_type_am_configuration }
    end
  end

  # GET /doc_type_am_configurations/1/edit
  def edit
    @doc_type_am_configuration = DocTypeAmConfiguration.find(params[:id])
  end

  # POST /doc_type_am_configurations
  # POST /doc_type_am_configurations.json
  def create
    @doc_type_am_configuration = DocTypeAmConfiguration.new(params[:doc_type_am_configuration])

    respond_to do |format|
      if @doc_type_am_configuration.save
        format.html { redirect_to @doc_type_am_configuration, notice: 'Doc type am configuration was successfully created.' }
        format.json { render json: @doc_type_am_configuration, status: :created, location: @doc_type_am_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @doc_type_am_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /doc_type_am_configurations/1
  # PUT /doc_type_am_configurations/1.json
  def update
    @doc_type_am_configuration = DocTypeAmConfiguration.find(params[:id])

    respond_to do |format|
      if @doc_type_am_configuration.update_attributes(params[:doc_type_am_configuration])
        format.html { redirect_to @doc_type_am_configuration, notice: 'Doc type am configuration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @doc_type_am_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doc_type_am_configurations/1
  # DELETE /doc_type_am_configurations/1.json
  def destroy
    @doc_type_am_configuration = DocTypeAmConfiguration.find(params[:id])
    @doc_type_am_configuration.destroy

    respond_to do |format|
      format.html { redirect_to doc_type_am_configurations_url }
      format.json { head :ok }
    end
  end
end
