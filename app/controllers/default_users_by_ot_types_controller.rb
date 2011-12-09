class DefaultUsersByOtTypesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 1
  end

  # GET /default_users_by_ot_types
  # GET /default_users_by_ot_types.json
  def index
    @default_users_by_ot_types = DefaultUsersByOtType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @default_users_by_ot_types }
    end
  end

  # GET /default_users_by_ot_types/1
  # GET /default_users_by_ot_types/1.json
  def show
    @default_users_by_ot_type = DefaultUsersByOtType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @default_users_by_ot_type }
    end
  end

  # GET /default_users_by_ot_types/new
  # GET /default_users_by_ot_types/new.json
  def new
    @default_users_by_ot_type = DefaultUsersByOtType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @default_users_by_ot_type }
    end
  end

  # GET /default_users_by_ot_types/1/edit
  def edit
    @default_users_by_ot_type = DefaultUsersByOtType.find(params[:id])
  end

  # POST /default_users_by_ot_types
  # POST /default_users_by_ot_types.json
  def create
    @default_users_by_ot_type = DefaultUsersByOtType.new(params[:default_users_by_ot_type])

    respond_to do |format|
      if @default_users_by_ot_type.save
        format.html { redirect_to @default_users_by_ot_type, notice: 'Default users by ot type was successfully created.' }
        format.json { render json: @default_users_by_ot_type, status: :created, location: @default_users_by_ot_type }
      else
        format.html { render action: "new" }
        format.json { render json: @default_users_by_ot_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /default_users_by_ot_types/1
  # PUT /default_users_by_ot_types/1.json
  def update
    @default_users_by_ot_type = DefaultUsersByOtType.find(params[:id])

    respond_to do |format|
      if @default_users_by_ot_type.update_attributes(params[:default_users_by_ot_type])
        format.html { redirect_to @default_users_by_ot_type, notice: 'Default users by ot type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @default_users_by_ot_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /default_users_by_ot_types/1
  # DELETE /default_users_by_ot_types/1.json
  def destroy
    @default_users_by_ot_type = DefaultUsersByOtType.find(params[:id])
    @default_users_by_ot_type.destroy

    respond_to do |format|
      format.html { redirect_to default_users_by_ot_types_url }
      format.json { head :ok }
    end
  end
end
