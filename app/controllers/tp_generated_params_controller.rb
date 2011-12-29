class TpGeneratedParamsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /tp_generated_params
  # GET /tp_generated_params.json
  def index
    @tp_generated_params = TpGeneratedParam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tp_generated_params }
    end
  end

  # GET /tp_generated_params/1
  # GET /tp_generated_params/1.json
  def show
    @tp_generated_param = TpGeneratedParam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tp_generated_param }
    end
  end

  # GET /tp_generated_params/new
  # GET /tp_generated_params/new.json
  def new
    @tp_generated_param = TpGeneratedParam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tp_generated_param }
    end
  end

  # GET /tp_generated_params/1/edit
  def edit
    @tp_generated_param = TpGeneratedParam.find(params[:id])
  end

  # POST /tp_generated_params
  # POST /tp_generated_params.json
  def create
    @tp_generated_param = TpGeneratedParam.new(params[:tp_generated_param])

    respond_to do |format|
      if @tp_generated_param.save
        format.html { redirect_to @tp_generated_param, notice: 'Tp generated param was successfully created.' }
        format.json { render json: @tp_generated_param, status: :created, location: @tp_generated_param }
      else
        format.html { render action: "new" }
        format.json { render json: @tp_generated_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tp_generated_params/1
  # PUT /tp_generated_params/1.json
  def update
    @tp_generated_param = TpGeneratedParam.find(params[:id])

    respond_to do |format|
      if @tp_generated_param.update_attributes(params[:tp_generated_param])
        format.html { redirect_to @tp_generated_param, notice: 'Tp generated param was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tp_generated_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tp_generated_params/1
  # DELETE /tp_generated_params/1.json
  def destroy
    @tp_generated_param = TpGeneratedParam.find(params[:id])
    @tp_generated_param.destroy

    respond_to do |format|
      format.html { redirect_to tp_generated_params_url }
      format.json { head :ok }
    end
  end
end
