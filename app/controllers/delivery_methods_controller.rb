class DeliveryMethodsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 2
  end

  # GET /delivery_methods
  # GET /delivery_methods.json
  def index
    @delivery_methods = DeliveryMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @delivery_methods }
    end
  end

  # GET /delivery_methods/1
  # GET /delivery_methods/1.json
  def show
    @delivery_method = DeliveryMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery_method }
    end
  end

  # GET /delivery_methods/new
  # GET /delivery_methods/new.json
  def new
    @delivery_method = DeliveryMethod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery_method }
    end
  end

  # GET /delivery_methods/1/edit
  def edit
    @delivery_method = DeliveryMethod.find(params[:id])
  end

  # POST /delivery_methods
  # POST /delivery_methods.json
  def create
    @delivery_method = DeliveryMethod.new(params[:delivery_method])

    respond_to do |format|
      if @delivery_method.save
        format.html { redirect_to @delivery_method, notice: 'Delivery method was successfully created.' }
        format.json { render json: @delivery_method, status: :created, location: @delivery_method }
      else
        format.html { render action: "new" }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /delivery_methods/1
  # PUT /delivery_methods/1.json
  def update
    @delivery_method = DeliveryMethod.find(params[:id])

    respond_to do |format|
      if @delivery_method.update_attributes(params[:delivery_method])
        format.html { redirect_to @delivery_method, notice: 'Delivery method was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_methods/1
  # DELETE /delivery_methods/1.json
  def destroy
    @delivery_method = DeliveryMethod.find(params[:id])
    @delivery_method.destroy

    respond_to do |format|
      format.html { redirect_to delivery_methods_url }
      format.json { head :ok }
    end
  end
end
