class OtStatesController < ApplicationController
  # GET /ot_states
  # GET /ot_states.json
  def index
    @ot_states = OtState.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ot_states }
    end
  end

  # GET /ot_states/1
  # GET /ot_states/1.json
  def show
    @ot_state = OtState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ot_state }
    end
  end

  # GET /ot_states/new
  # GET /ot_states/new.json
  def new
    @ot_state = OtState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ot_state }
    end
  end

  # GET /ot_states/1/edit
  def edit
    @ot_state = OtState.find(params[:id])
  end

  # POST /ot_states
  # POST /ot_states.json
  def create
    @ot_state = OtState.new(params[:ot_state])

    respond_to do |format|
      if @ot_state.save
        format.html { redirect_to @ot_state, notice: 'Ot state was successfully created.' }
        format.json { render json: @ot_state, status: :created, location: @ot_state }
      else
        format.html { render action: "new" }
        format.json { render json: @ot_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ot_states/1
  # PUT /ot_states/1.json
  def update
    @ot_state = OtState.find(params[:id])

    respond_to do |format|
      if @ot_state.update_attributes(params[:ot_state])
        format.html { redirect_to @ot_state, notice: 'Ot state was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ot_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ot_states/1
  # DELETE /ot_states/1.json
  def destroy
    @ot_state = OtState.find(params[:id])
    @ot_state.destroy

    respond_to do |format|
      format.html { redirect_to ot_states_url }
      format.json { head :ok }
    end
  end
end
