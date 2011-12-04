class TextContentsController < InheritedResources::Base
  has_scope :page, :default => 1
  load_and_authorize_resource
  uses_tiny_mce :only => [:new, :create, :edit, :update]
  helper_method :sort_column, :sort_direction
  
  def show
    session[:go_to_after_edit] = text_content_path(@text_content)
    show!
  end
  
  def index
    @menu = 'admin'
    session[:go_to_after_edit] = text_contents_path
    @text_contents = TextContent.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(25)
  end
  
  def create
    goto = session.delete(:go_to_after_edit) || collection_path
    create! {goto}
  end
  
  def update
    goto = session.delete(:go_to_after_edit) || collection_path
    create! {goto}
  end
  
private  
  def sort_column  
    TextContent.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end
