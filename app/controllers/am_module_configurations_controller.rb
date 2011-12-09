class AmModuleConfigurationsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /am_module_configurations
  # GET /am_module_configurations.json
  def index
    @am_module_configurations = AmModuleConfiguration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @am_module_configurations }
    end
  end

  # GET /am_module_configurations/1
  # GET /am_module_configurations/1.json
  def show
    @am_module_configuration = AmModuleConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @am_module_configuration }
    end
  end

  # GET /am_module_configurations/new
  # GET /am_module_configurations/new.json
  def new
    @am_module_configuration = AmModuleConfiguration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @am_module_configuration }
    end
  end

  # GET /am_module_configurations/1/edit
  def edit
    @am_module_configuration = AmModuleConfiguration.find(params[:id])
  end

  # POST /am_module_configurations
  # POST /am_module_configurations.json
  def create
    @am_module_configuration = AmModuleConfiguration.new(params[:am_module_configuration])

    respond_to do |format|
      if @am_module_configuration.save
        format.html { redirect_to @am_module_configuration, notice: 'Am module configuration was successfully created.' }
        format.json { render json: @am_module_configuration, status: :created, location: @am_module_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @am_module_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /am_module_configurations/1
  # PUT /am_module_configurations/1.json
  def update
    @am_module_configuration = AmModuleConfiguration.find(params[:id])

    respond_to do |format|
      if @am_module_configuration.update_attributes(params[:am_module_configuration])
        format.html { redirect_to @am_module_configuration, notice: 'Am module configuration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @am_module_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /am_module_configurations/1
  # DELETE /am_module_configurations/1.json
  def destroy
    @am_module_configuration = AmModuleConfiguration.find(params[:id])
    @am_module_configuration.destroy

    respond_to do |format|
      format.html { redirect_to am_module_configurations_url }
      format.json { head :ok }
    end
  end
end
