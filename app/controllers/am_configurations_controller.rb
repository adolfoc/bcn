class AmConfigurationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /am_configurations
  # GET /am_configurations.json
  def index
    @am_configurations = AmConfiguration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @am_configurations }
    end
  end

  # GET /am_configurations/1
  # GET /am_configurations/1.json
  def show
    @am_configuration = AmConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @am_configuration }
    end
  end

  # GET /am_configurations/new
  # GET /am_configurations/new.json
  def new
    @am_configuration = AmConfiguration.new

    @am_configuration.structural_markup_enabled = true
    @am_configuration.structural_markup_extension_whole_document = true
    @am_configuration.structural_markup_depth_all = true
    @am_configuration.semantic_markup_enabled = true
    @am_configuration.semantic_markup_extension_whole_document = true
    @am_configuration.semantic_markup_depth_all = true

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @am_configuration }
    end
  end

  # GET /am_configurations/1/edit
  def edit
    @am_configuration = AmConfiguration.find(params[:id])
  end

  # POST /am_configurations
  # POST /am_configurations.json
  def create
    @am_configuration = AmConfiguration.new(params[:am_configuration])

    respond_to do |format|
      if @am_configuration.save
        format.html { redirect_to @am_configuration, notice: 'Am configuration was successfully created.' }
        format.json { render json: @am_configuration, status: :created, location: @am_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @am_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /am_configurations/1
  # PUT /am_configurations/1.json
  def update
    @am_configuration = AmConfiguration.find(params[:id])

    respond_to do |format|
      if @am_configuration.update_attributes(params[:am_configuration])
        format.html { redirect_to @am_configuration, notice: 'Am configuration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @am_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /am_configurations/1
  # DELETE /am_configurations/1.json
  def destroy
    @am_configuration = AmConfiguration.find(params[:id])
    @am_configuration.destroy

    respond_to do |format|
      format.html { redirect_to am_configurations_url }
      format.json { head :ok }
    end
  end
end
