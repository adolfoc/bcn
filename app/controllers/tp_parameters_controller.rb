class TpParametersController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /tp_parameters
  # GET /tp_parameters.json
  def index
    @tp_parameters = TpParameter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tp_parameters }
    end
  end

  # GET /tp_parameters/1
  # GET /tp_parameters/1.json
  def show
    @tp_parameter = TpParameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tp_parameter }
    end
  end

  # GET /tp_parameters/new
  # GET /tp_parameters/new.json
  def new
    @tp_parameter = TpParameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tp_parameter }
    end
  end

  # GET /tp_parameters/1/edit
  def edit
    @tp_parameter = TpParameter.find(params[:id])
  end

  # POST /tp_parameters
  # POST /tp_parameters.json
  def create
    @tp_parameter = TpParameter.new(params[:tp_parameter])

    respond_to do |format|
      if @tp_parameter.save
        format.html { redirect_to @tp_parameter, notice: 'Tp parameter was successfully created.' }
        format.json { render json: @tp_parameter, status: :created, location: @tp_parameter }
      else
        format.html { render action: "new" }
        format.json { render json: @tp_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tp_parameters/1
  # PUT /tp_parameters/1.json
  def update
    @tp_parameter = TpParameter.find(params[:id])

    respond_to do |format|
      if @tp_parameter.update_attributes(params[:tp_parameter])
        format.html { redirect_to @tp_parameter, notice: 'Tp parameter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tp_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tp_parameters/1
  # DELETE /tp_parameters/1.json
  def destroy
    @tp_parameter = TpParameter.find(params[:id])
    @tp_parameter.destroy

    respond_to do |format|
      format.html { redirect_to tp_parameters_url }
      format.json { head :ok }
    end
  end
end
