class AmResultsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 4
  end

  # GET /am_results
  # GET /am_results.json
  def index
    @am_results = AmResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @am_results }
    end
  end

  # GET /am_results/1
  # GET /am_results/1.json
  def show
    @am_result = AmResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @am_result }
    end
  end

  # GET /am_results/new
  # GET /am_results/new.json
  def new
    @am_result = AmResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @am_result }
    end
  end

  # GET /am_results/1/edit
  def edit
    @am_result = AmResult.find(params[:id])
  end

  # POST /am_results
  # POST /am_results.json
  def create
    @am_result = AmResult.new(params[:am_result])

    respond_to do |format|
      if @am_result.save
        format.html { redirect_to @am_result, notice: 'Am result was successfully created.' }
        format.json { render json: @am_result, status: :created, location: @am_result }
      else
        format.html { render action: "new" }
        format.json { render json: @am_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /am_results/1
  # PUT /am_results/1.json
  def update
    @am_result = AmResult.find(params[:id])

    respond_to do |format|
      if @am_result.update_attributes(params[:am_result])
        format.html { redirect_to @am_result, notice: 'Am result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @am_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /am_results/1
  # DELETE /am_results/1.json
  def destroy
    @am_result = AmResult.find(params[:id])
    @am_result.destroy

    respond_to do |format|
      format.html { redirect_to am_results_url }
      format.json { head :ok }
    end
  end
end
