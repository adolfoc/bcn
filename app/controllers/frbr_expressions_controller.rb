class FrbrExpressionsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /frbr_expressions
  # GET /frbr_expressions.json
  def index
    screen_name("Admin-Indice-Expresiones-FRBR")
    @frbr_expressions = FrbrExpression.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @frbr_expressions }
    end
  end

  # GET /frbr_expressions/1
  # GET /frbr_expressions/1.json
  def show
    screen_name("Admin-Mostrar-Expresion-FRBR")
    @frbr_expression = FrbrExpression.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @frbr_expression }
    end
  end

  # GET /frbr_expressions/new
  # GET /frbr_expressions/new.json
  def new
    screen_name("Admin-Nuevo-Expresion-FRBR")
    @frbr_expression = FrbrExpression.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @frbr_expression }
    end
  end

  # GET /frbr_expressions/1/edit
  def edit
    screen_name("Admin-Editar-Expresion-FRBR")
    @frbr_expression = FrbrExpression.find(params[:id])
  end

  # POST /frbr_expressions
  # POST /frbr_expressions.json
  def create
    @frbr_expression = FrbrExpression.new(params[:frbr_expression])

    respond_to do |format|
      if @frbr_expression.save
        format.html { redirect_to @frbr_expression, notice: 'Frbr expression was successfully created.' }
        format.json { render json: @frbr_expression, status: :created, location: @frbr_expression }
      else
        format.html { render action: "new" }
        format.json { render json: @frbr_expression.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_expressions/1
  # PUT /frbr_expressions/1.json
  def update
    @frbr_expression = FrbrExpression.find(params[:id])

    respond_to do |format|
      if @frbr_expression.update_attributes(params[:frbr_expression])
        format.html { redirect_to @frbr_expression, notice: 'Frbr expression was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @frbr_expression.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_expressions/1
  # DELETE /frbr_expressions/1.json
  def destroy
    @frbr_expression = FrbrExpression.find(params[:id])
    @frbr_expression.destroy

    respond_to do |format|
      format.html { redirect_to frbr_expressions_url }
      format.json { head :ok }
    end
  end
end
