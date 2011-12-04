class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  before_filter :get_site_info

  #!!! do i have to featch all this all the time?
  def get_site_info
    @menu = 'home'
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to no_access_index_path, :alert => exception.message
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin_or_super?
      admin_index_path
    else
      user_path(resource)
    end
  end

end
