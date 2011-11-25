class IntermediariesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /intermediaries
  # GET /intermediaries.json
  def index
    @intermediaries = Intermediary.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @intermediaries }
    end
  end

  # GET /intermediaries/1
  # GET /intermediaries/1.json
  def show
    @intermediary = Intermediary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @intermediary }
    end
  end

  # GET /intermediaries/new
  # GET /intermediaries/new.json
  def new
    @intermediary = Intermediary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @intermediary }
    end
  end

  # GET /intermediaries/1/edit
  def edit
    @intermediary = Intermediary.find(params[:id])
  end

  # POST /intermediaries
  # POST /intermediaries.json
  def create
    @intermediary = Intermediary.new(params[:intermediary])

    respond_to do |format|
      if @intermediary.save
        format.html { redirect_to @intermediary, notice: 'Intermediary was successfully created.' }
        format.json { render json: @intermediary, status: :created, location: @intermediary }
      else
        format.html { render action: "new" }
        format.json { render json: @intermediary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /intermediaries/1
  # PUT /intermediaries/1.json
  def update
    @intermediary = Intermediary.find(params[:id])

    respond_to do |format|
      if @intermediary.update_attributes(params[:intermediary])
        format.html { redirect_to @intermediary, notice: 'Intermediary was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @intermediary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intermediaries/1
  # DELETE /intermediaries/1.json
  def destroy
    @intermediary = Intermediary.find(params[:id])
    @intermediary.destroy

    respond_to do |format|
      format.html { redirect_to intermediaries_url }
      format.json { head :ok }
    end
  end
end
