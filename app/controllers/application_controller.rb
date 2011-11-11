class ApplicationController < ActionController::Base
  protect_from_forgery

  def screen_name(screen_name)
    @pantalla = screen_name
  end
end
