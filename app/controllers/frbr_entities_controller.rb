class FrbrEntitiesController < ApplicationController
  # GET /frbr_entities
  # GET /frbr_entities.json
  def index
    @frbr_entities = FrbrEntity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_entities }
    end
  end

  # GET /frbr_entities/1
  # GET /frbr_entities/1.json
  def show
    @frbr_entity = FrbrEntity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_entity }
    end
  end

  # GET /frbr_entities/new
  # GET /frbr_entities/new.json
  def new
    @frbr_entity = FrbrEntity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_entity }
    end
  end

  # GET /frbr_entities/1/edit
  def edit
    @frbr_entity = FrbrEntity.find(params[:id])
  end

  # POST /frbr_entities
  # POST /frbr_entities.json
  def create
    @frbr_entity = FrbrEntity.new(params[:frbr_entity])

    respond_to do |format|
      if @frbr_entity.save
        format.html { redirect_to @frbr_entity, notice: 'Frbr entity was successfully created.' }
        format.json { render json: @frbr_entity, status: :created, location: @frbr_entity }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_entities/1
  # PUT /frbr_entities/1.json
  def update
    @frbr_entity = FrbrEntity.find(params[:id])

    respond_to do |format|
      if @frbr_entity.update_attributes(params[:frbr_entity])
        format.html { redirect_to @frbr_entity, notice: 'Frbr entity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_entities/1
  # DELETE /frbr_entities/1.json
  def destroy
    @frbr_entity = FrbrEntity.find(params[:id])
    @frbr_entity.destroy

    respond_to do |format|
      format.html { redirect_to frbr_entities_url }
      format.json { head :ok }
    end
  end
end
