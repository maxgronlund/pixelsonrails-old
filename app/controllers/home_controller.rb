class HomeController < ApplicationController
  
  def index
    @menu = 'home'
    session[:go_to_after_edit] = root_path
    @welcome = TextContent.welcome
  end

end
