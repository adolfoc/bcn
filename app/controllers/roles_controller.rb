class RolesController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 1
  end

  # GET /roles
  # GET /roles.json
  def index
    screen_name("Admin-Indice-Roles")
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    screen_name("Admin-Mostrar-Rol")
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.json
  def new
    screen_name("Admin-Nuevo-Rol")
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @role }
    end
  end

  # GET /roles/1/edit
  def edit
    screen_name("Admin-Editar-Rol")
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render json: @role, status: :created, location: @role }
      else
        format.html { render action: "new" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.json
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :ok }
    end
  end
end
