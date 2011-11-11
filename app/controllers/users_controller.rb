class UsersController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 1
  end

  def index
    screen_name("Indice-Usuarios")
    @users = User.all
  end
end
