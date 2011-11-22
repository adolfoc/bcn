class WorkLoadController < ApplicationController
  def index
    screen_name("carga_de_trabajo")

    @tasks = Task.paginate(:page => params[:page], :per_page => 10)
  end

  def select
    screen_name("carga_de_trabajo")

    @tasks = Task.where("current_user_id = #{params[:user_id]}").paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html { render action: "index" }
      format.json { head :ok }
    end
  end
end
