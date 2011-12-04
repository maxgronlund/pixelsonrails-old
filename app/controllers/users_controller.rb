class UsersController < InheritedResources::Base  
  has_scope :page, :default => 1
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction

  
  def index
    @menu='admin'
    return_path users_path # !!! same as line 10?
#    @is_first_user = User.first.id == 1
    session[:go_to_after_edit] = users_path
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(25)
  end

  def show
    return_path user_path  # !!! perhaps a system vide helper ?
    show!
  end

  
  def create
    @user = User.new(params[:user])  
    if @user.save  
      if params[:user][:image]
        redirect_to crop_user_path, :notice => "Signed up!"
      else
        redirect_to user_path(@user), :notice => "Signed up!"
      end
    else  
      render "new"  
    end  
  end  
  
  
  def crop
    @crop_version = (params[:version] || :large).to_sym
    @user.get_crop_version! @crop_version
    @version_geometry_width, @version_geometry_height = AvatarUploader.version_dimensions[@crop_version]
  end

  def crop_update
  #  @user = current_user                        #!!! current user? no no no 
    @user = User.find(params[:id])
    @user.crop_x = params[:user]["crop_x"]
    @user.crop_y = params[:user]["crop_y"]
    @user.crop_h = params[:user]["crop_h"]
    @user.crop_w = params[:user]["crop_w"]
    @user.crop_version = params[:user]["crop_version"]
    @user.save

    redirect_to return_path(edit_user_path(@user))
  end
  
  def update
    remove_password_fields_if_blank! params[:user]
    
    if params[:user][:image] && params[:user][:remove_image] != '1'
      update! { crop_user_path }
    else
      update! { return_path(user_path) }
    end
   end
   
  
private

  def remove_password_fields_if_blank!(user_params)
    if user_params[:password].blank? and user_params[:password_confirmation].blank?
      user_params.delete :password
      user_params.delete :password_confirmation
    end
  end

  def return_path=(path)
    session[:go_to_after_edit] = path
  end

  def return_path(default_path)
    (session[:go_to_after_edit] || default_path).tap do |path|
      session[:go_to_after_edit] = nil
    end
  end

  def sort_column  
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end
