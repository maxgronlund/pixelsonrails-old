class TeamController < ApplicationController
  def index
    session[:go_to_after_edit] = users_path
    @users = User.order('name asc')
  end

end
