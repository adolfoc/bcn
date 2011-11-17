class WorkLoadController < ApplicationController
  def index
    screen_name("carga_de_trabajo")

    @tasks = Task.all
  end

  def select
    screen_name("carga_de_trabajo")

    @tasks = Task.where("current_user_id = #{params[:user_id]}")

    respond_to do |format|
      format.html { render action: "index" }
      format.json { head :ok }
    end
  end
end
