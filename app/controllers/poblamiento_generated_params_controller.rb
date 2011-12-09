class PoblamientoGeneratedParamsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 5
  end

  # GET /poblamiento_generated_params
  # GET /poblamiento_generated_params.json
  def index
    @poblamiento_generated_params = PoblamientoGeneratedParam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poblamiento_generated_params }
    end
  end

  # GET /poblamiento_generated_params/1
  # GET /poblamiento_generated_params/1.json
  def show
    @poblamiento_generated_param = PoblamientoGeneratedParam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poblamiento_generated_param }
    end
  end

  # GET /poblamiento_generated_params/new
  # GET /poblamiento_generated_params/new.json
  def new
    @poblamiento_generated_param = PoblamientoGeneratedParam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poblamiento_generated_param }
    end
  end

  # GET /poblamiento_generated_params/1/edit
  def edit
    @poblamiento_generated_param = PoblamientoGeneratedParam.find(params[:id])
  end

  # POST /poblamiento_generated_params
  # POST /poblamiento_generated_params.json
  def create
    @poblamiento_generated_param = PoblamientoGeneratedParam.new(params[:poblamiento_generated_param])

    respond_to do |format|
      if @poblamiento_generated_param.save
        format.html { redirect_to @poblamiento_generated_param, notice: 'Poblamiento generated param was successfully created.' }
        format.json { render json: @poblamiento_generated_param, status: :created, location: @poblamiento_generated_param }
      else
        format.html { render action: "new" }
        format.json { render json: @poblamiento_generated_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /poblamiento_generated_params/1
  # PUT /poblamiento_generated_params/1.json
  def update
    @poblamiento_generated_param = PoblamientoGeneratedParam.find(params[:id])

    respond_to do |format|
      if @poblamiento_generated_param.update_attributes(params[:poblamiento_generated_param])
        format.html { redirect_to @poblamiento_generated_param, notice: 'Poblamiento generated param was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @poblamiento_generated_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poblamiento_generated_params/1
  # DELETE /poblamiento_generated_params/1.json
  def destroy
    @poblamiento_generated_param = PoblamientoGeneratedParam.find(params[:id])
    @poblamiento_generated_param.destroy

    respond_to do |format|
      format.html { redirect_to poblamiento_generated_params_url }
      format.json { head :ok }
    end
  end
end
