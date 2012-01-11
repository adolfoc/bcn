class DebateTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 6
  end

  # GET /debate_types
  # GET /debate_types.json
  def index
    @debate_types = DebateType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @debate_types }
    end
  end

  # GET /debate_types/1
  # GET /debate_types/1.json
  def show
    @debate_type = DebateType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @debate_type }
    end
  end

  # GET /debate_types/new
  # GET /debate_types/new.json
  def new
    @debate_type = DebateType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @debate_type }
    end
  end

  # GET /debate_types/1/edit
  def edit
    @debate_type = DebateType.find(params[:id])
  end

  # POST /debate_types
  # POST /debate_types.json
  def create
    @debate_type = DebateType.new(params[:debate_type])

    respond_to do |format|
      if @debate_type.save
        format.html { redirect_to @debate_type, notice: 'Debate type was successfully created.' }
        format.json { render json: @debate_type, status: :created, location: @debate_type }
      else
        format.html { render action: "new" }
        format.json { render json: @debate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /debate_types/1
  # PUT /debate_types/1.json
  def update
    @debate_type = DebateType.find(params[:id])

    respond_to do |format|
      if @debate_type.update_attributes(params[:debate_type])
        format.html { redirect_to @debate_type, notice: 'Debate type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @debate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debate_types/1
  # DELETE /debate_types/1.json
  def destroy
    @debate_type = DebateType.find(params[:id])
    @debate_type.destroy

    respond_to do |format|
      format.html { redirect_to debate_types_url }
      format.json { head :ok }
    end
  end
end
