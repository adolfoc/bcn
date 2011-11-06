class UsersController < ApplicationController
  before_filter :set_menu_section

  def set_menu_section
    @accordion_section = 1
  end

  def index
    @users = User.all
  end
end
