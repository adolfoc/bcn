class MarkupToolsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /markup_tools
  # GET /markup_tools.json
  def index
    @markup_tools = MarkupTool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @markup_tools }
    end
  end

  # GET /markup_tools/1
  # GET /markup_tools/1.json
  def show
    @markup_tool = MarkupTool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @markup_tool }
    end
  end

  # GET /markup_tools/new
  # GET /markup_tools/new.json
  def new
    @markup_tool = MarkupTool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @markup_tool }
    end
  end

  # GET /markup_tools/1/edit
  def edit
    @markup_tool = MarkupTool.find(params[:id])
  end

  # POST /markup_tools
  # POST /markup_tools.json
  def create
    @markup_tool = MarkupTool.new(params[:markup_tool])

    respond_to do |format|
      if @markup_tool.save
        format.html { redirect_to @markup_tool, notice: 'Markup tool was successfully created.' }
        format.json { render json: @markup_tool, status: :created, location: @markup_tool }
      else
        format.html { render action: "new" }
        format.json { render json: @markup_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /markup_tools/1
  # PUT /markup_tools/1.json
  def update
    @markup_tool = MarkupTool.find(params[:id])

    respond_to do |format|
      if @markup_tool.update_attributes(params[:markup_tool])
        format.html { redirect_to @markup_tool, notice: 'Markup tool was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @markup_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markup_tools/1
  # DELETE /markup_tools/1.json
  def destroy
    @markup_tool = MarkupTool.find(params[:id])
    @markup_tool.destroy

    respond_to do |format|
      format.html { redirect_to markup_tools_url }
      format.json { head :ok }
    end
  end
end
