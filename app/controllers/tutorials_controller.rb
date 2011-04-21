class TutorialsController < InheritedResources::Base
  
  
  load_and_authorize_resource
#  uses_tiny_mce :only => [:new, :create, :edit, :update]
  
  helper_method :sort_column, :sort_direction
  
  def index
    @tutorials = Tutorial.order(sort_column + ' ' + sort_direction).paginate(:per_page => 25, :page => params[:page])
  end
   
   

private  
  def sort_column  
    Tutorial.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 

  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
end

