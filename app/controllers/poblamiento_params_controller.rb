class PoblamientoParamsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 5
  end

  # GET /poblamiento_params
  # GET /poblamiento_params.json
  def index
    @poblamiento_params = PoblamientoParam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poblamiento_params }
    end
  end

  # GET /poblamiento_params/1
  # GET /poblamiento_params/1.json
  def show
    @poblamiento_param = PoblamientoParam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poblamiento_param }
    end
  end

  # GET /poblamiento_params/new
  # GET /poblamiento_params/new.json
  def new
    @poblamiento_param = PoblamientoParam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poblamiento_param }
    end
  end

  # GET /poblamiento_params/1/edit
  def edit
    @poblamiento_param = PoblamientoParam.find(params[:id])
  end

  # POST /poblamiento_params
  # POST /poblamiento_params.json
  def create
    @poblamiento_param = PoblamientoParam.new(params[:poblamiento_param])

    respond_to do |format|
      if @poblamiento_param.save
        format.html { redirect_to @poblamiento_param, notice: 'Poblamiento param was successfully created.' }
        format.json { render json: @poblamiento_param, status: :created, location: @poblamiento_param }
      else
        format.html { render action: "new" }
        format.json { render json: @poblamiento_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /poblamiento_params/1
  # PUT /poblamiento_params/1.json
  def update
    @poblamiento_param = PoblamientoParam.find(params[:id])

    respond_to do |format|
      if @poblamiento_param.update_attributes(params[:poblamiento_param])
        format.html { redirect_to @poblamiento_param, notice: 'Poblamiento param was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @poblamiento_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poblamiento_params/1
  # DELETE /poblamiento_params/1.json
  def destroy
    @poblamiento_param = PoblamientoParam.find(params[:id])
    @poblamiento_param.destroy

    respond_to do |format|
      format.html { redirect_to poblamiento_params_url }
      format.json { head :ok }
    end
  end
end
