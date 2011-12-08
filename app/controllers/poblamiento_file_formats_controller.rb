class PoblamientoFileFormatsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 5
  end

  # GET /poblamiento_file_formats
  # GET /poblamiento_file_formats.json
  def index
    @poblamiento_file_formats = PoblamientoFileFormat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poblamiento_file_formats }
    end
  end

  # GET /poblamiento_file_formats/1
  # GET /poblamiento_file_formats/1.json
  def show
    @poblamiento_file_format = PoblamientoFileFormat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poblamiento_file_format }
    end
  end

  # GET /poblamiento_file_formats/new
  # GET /poblamiento_file_formats/new.json
  def new
    @poblamiento_file_format = PoblamientoFileFormat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poblamiento_file_format }
    end
  end

  # GET /poblamiento_file_formats/1/edit
  def edit
    @poblamiento_file_format = PoblamientoFileFormat.find(params[:id])
  end

  # POST /poblamiento_file_formats
  # POST /poblamiento_file_formats.json
  def create
    @poblamiento_file_format = PoblamientoFileFormat.new(params[:poblamiento_file_format])

    respond_to do |format|
      if @poblamiento_file_format.save
        format.html { redirect_to @poblamiento_file_format, notice: 'Poblamiento file format was successfully created.' }
        format.json { render json: @poblamiento_file_format, status: :created, location: @poblamiento_file_format }
      else
        format.html { render action: "new" }
        format.json { render json: @poblamiento_file_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /poblamiento_file_formats/1
  # PUT /poblamiento_file_formats/1.json
  def update
    @poblamiento_file_format = PoblamientoFileFormat.find(params[:id])

    respond_to do |format|
      if @poblamiento_file_format.update_attributes(params[:poblamiento_file_format])
        format.html { redirect_to @poblamiento_file_format, notice: 'Poblamiento file format was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @poblamiento_file_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poblamiento_file_formats/1
  # DELETE /poblamiento_file_formats/1.json
  def destroy
    @poblamiento_file_format = PoblamientoFileFormat.find(params[:id])
    @poblamiento_file_format.destroy

    respond_to do |format|
      format.html { redirect_to poblamiento_file_formats_url }
      format.json { head :ok }
    end
  end
end
