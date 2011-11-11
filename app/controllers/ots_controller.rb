class OtsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /ots
  # GET /ots.json
  def index
    @ots = Ot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ots }
    end
  end

  # GET /ots/1
  # GET /ots/1.json
  def show
    @ot = Ot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ot }
    end
  end

  # GET /ots/new
  # GET /ots/new.json
  def new
    @ot = Ot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ot }
    end
  end

  # GET /ots/1/edit
  def edit
    @ot = Ot.find(params[:id])
  end

  def get_basic_task_params
    task_params = Hash.new
    task_params[:created_by] = current_user.id
    task_params[:created_on] = DateTime.now
    task_params[:ot_id] = @ot.id
    task_params[:priority_id] = @ot.priority_id
    task_params
  end

  def create_plan_marcado_cuenta_task
    task_params = get_basic_task_params
    task_params[:task_type_id] = 4
    plan_cuenta_task = PlanCuentaTask.new(task_params)
    plan_cuenta_task.workflow_state = plan_cuenta_task.initial_task
    plan_cuenta_task.save
  end

  def create_marcado_cuenta_task
    task_params = get_basic_task_params
    task_params[:task_type_id] = 1
    marcado_cuenta_task = MarcadoCuentaTask.new(task_params)
    marcado_cuenta_task.workflow_state = marcado_cuenta_task.initial_task
    marcado_cuenta_task.save
  end

  def create_qa_cuenta_task
    task_params = get_basic_task_params
    task_params[:task_type_id] = 5
    qa_cuenta_task = QaCuentaTask.new(task_params)
    qa_cuenta_task.workflow_state = qa_cuenta_task.initial_task
    qa_cuenta_task.save
  end

  # POST /ots
  # POST /ots.json
  def create
    @ot = Ot.new(params[:ot])

    respond_to do |format|
      if @ot.save
        if @ot.ot_type_id == 1
          create_plan_marcado_cuenta_task
          create_marcado_cuenta_task
          create_qa_cuenta_task
        end
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
