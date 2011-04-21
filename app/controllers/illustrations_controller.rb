class IllustrationsController < InheritedResources::Base
    load_and_authorize_resource
    respond_to :js, :only => [:create, :update]
    
    helper_method :sort_column, :sort_direction 

    def index
      @illustrations = Illustration.order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])
    end
    
    def update 
      @illustration = Illustration.find(params[:id])
      @illustration.update_attributes(params[:illustration])
      @illustration.image_content_type = MIME::Types.type_for(@illustration.image.original_filename).first.to_s if @illustration.image.original_filename.present?
      @illustration.save
      update! {illustration_path(@illustration)}
    end
  
    def create  
      @illustration = Illustration.new(params[:illustration])
      @illustration.image_content_type = MIME::Types.type_for(@illustration.image.original_filename).first.to_s if @illustration.image.original_filename.present?
      @illustration.save
      create! {illustration_path(@illustration)}
    end
  
private  
  def sort_column  
    Illustration.column_names.include?(params[:sort]) ? params[:sort] : "title"  
  end 
  
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
  end
    
    
end
