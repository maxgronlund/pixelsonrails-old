# encoding: utf-8
class BlogsController < InheritedResources::Base
  
  load_and_authorize_resource
  
  
  belongs_to :user , :optional => true
  
  def index
    @blogs = Blog.language.order('created_at DESC').paginate(:per_page => 4, :page => params[:page])
  end
  
  def new
    @blog = Blog.new
    @user = current_user
    @blog.language = 'en'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog }
    end
  end
  
  def update
    
    update! {blogs_path}
  end
  
  def create
    
    create! {blogs_path}
  end
  
#  def new 
#    @user = current_user
#  end
end
