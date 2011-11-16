class OtsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /ots
  # GET /ots.json
  def index
    screen_name("Admin-Indice-OTs")
    @ots = Ot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ots }
    end
  end

  # GET /ots/1
  # GET /ots/1.json
  def show
    screen_name("Admin-Mostrar-OT")
    @ot = Ot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ot }
    end
  end

  # GET /ots/new
  # GET /ots/new.json
  def new
    screen_name("Admin-Nueva-OT")
    @ot = Ot.new
    @ot.created_by = current_user.id
    @ot.target_date = DateTime.now + 2

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ot }
    end
  end

  # GET /ots/1/edit
  def edit
    screen_name("Admin-Editar-OT")
    @ot = Ot.find(params[:id])
  end

  # POST /ots
  # POST /ots.json
  def create
    @ot = Ot.new(params[:ot])

    respond_to do |format|
      if @ot.save
        @ot.create_tasks(current_user)
        format.html { redirect_to @ot, notice: 'Ot was successfully created.' }
        format.json { render json: @ot, status: :created, location: @ot }
      else
        format.html { render action: "new" }
        format.json { render json: @ot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ots/1
  # PUT /ots/1.json
  def update
    @ot = Ot.find(params[:id])

    respond_to do |format|
      if @ot.update_attributes(params[:ot])
        format.html { redirect_to @ot, notice: 'Ot was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ots/1
  # DELETE /ots/1.json
  def destroy
    @ot = Ot.find(params[:id])
    @ot.destroy

    respond_to do |format|
      format.html { redirect_to ots_url }
      format.json { head :ok }
    end
  end
end
