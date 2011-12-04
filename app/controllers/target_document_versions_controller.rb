class TargetDocumentVersionsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /target_document_versions
  # GET /target_document_versions.json
  def index
    @target_document_versions = TargetDocumentVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @target_document_versions }
    end
  end

  # GET /target_document_versions/1
  # GET /target_document_versions/1.json
  def show
    @target_document_version = TargetDocumentVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @target_document_version }
    end
  end

  # GET /target_document_versions/new
  # GET /target_document_versions/new.json
  def new
    @target_document_version = TargetDocumentVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @target_document_version }
    end
  end

  # GET /target_document_versions/1/edit
  def edit
    @target_document_version = TargetDocumentVersion.find(params[:id])
  end

  # POST /target_document_versions
  # POST /target_document_versions.json
  def create
    @target_document_version = TargetDocumentVersion.new(params[:target_document_version])

    respond_to do |format|
      if @target_document_version.save
        format.html { redirect_to @target_document_version, notice: 'Target document version was successfully created.' }
        format.json { render json: @target_document_version, status: :created, location: @target_document_version }
      else
        format.html { render action: "new" }
        format.json { render json: @target_document_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /target_document_versions/1
  # PUT /target_document_versions/1.json
  def update
    @target_document_version = TargetDocumentVersion.find(params[:id])

    respond_to do |format|
      if @target_document_version.update_attributes(params[:target_document_version])
        format.html { redirect_to @target_document_version, notice: 'Target document version was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @target_document_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_document_versions/1
  # DELETE /target_document_versions/1.json
  def destroy
    @target_document_version = TargetDocumentVersion.find(params[:id])
    @target_document_version.destroy

    respond_to do |format|
      format.html { redirect_to target_document_versions_url }
      format.json { head :ok }
    end
  end
end
