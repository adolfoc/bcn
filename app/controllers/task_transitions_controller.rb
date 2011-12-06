class TaskTransitionsController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 3
  end

  # GET /task_transitions
  # GET /task_transitions.json
  def index
    @task_transitions = TaskTransition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_transitions }
    end
  end

  # GET /task_transitions/1
  # GET /task_transitions/1.json
  def show
    @task_transition = TaskTransition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_transition }
    end
  end

  # GET /task_transitions/new
  # GET /task_transitions/new.json
  def new
    @task_transition = TaskTransition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_transition }
    end
  end

  # GET /task_transitions/1/edit
  def edit
    @task_transition = TaskTransition.find(params[:id])
  end

  # POST /task_transitions
  # POST /task_transitions.json
  def create
    @task_transition = TaskTransition.new(params[:task_transition])

    respond_to do |format|
      if @task_transition.save
        format.html { redirect_to @task_transition, notice: 'Task transition was successfully created.' }
        format.json { render json: @task_transition, status: :created, location: @task_transition }
      else
        format.html { render action: "new" }
        format.json { render json: @task_transition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_transitions/1
  # PUT /task_transitions/1.json
  def update
    @task_transition = TaskTransition.find(params[:id])

    respond_to do |format|
      if @task_transition.update_attributes(params[:task_transition])
        format.html { redirect_to @task_transition, notice: 'Task transition was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_transition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_transitions/1
  # DELETE /task_transitions/1.json
  def destroy
    @task_transition = TaskTransition.find(params[:id])
    @task_transition.destroy

    respond_to do |format|
      format.html { redirect_to task_transitions_url }
      format.json { head :ok }
    end
  end
end
