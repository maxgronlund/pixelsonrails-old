class CasestorriesController < InheritedResources::Base
    load_and_authorize_resource
    respond_to :js, :only => [:create, :update]
    
    helper_method :sort_column, :sort_direction 

    def index
      @casestorries = Casestorry.order(sort_column + ' ' + sort_direction).paginate(:per_page => 12, :page => params[:page])
    end

    def update 
      @casestorry = Casestorry.find(params[:id])
      @casestorry.update_attributes(params[:casestorry])
      @casestorry.image_content_type = MIME::Types.type_for(@casestorry.image.original_filename).first.to_s if @casestorry.image.original_filename.present?
      @casestorry.save
      update! {casestorry_path(@casestorry)}
    end
  
#    def create  
#      @casestorry = Casestorry.new(params[:casestorry])
#      @casestorry.image_content_type = MIME::Types.type_for(@casestorry.image.original_filename).first.to_s if @casestorry.image.original_filename.present?
#      @casestorry.save
#      create! {casestorry_path(@casestorry)}
#    end
    def create  
      @casestorry = Casestorry.new(params[:casestorry])
      @casestorry.image_content_type = MIME::Types.type_for(@casestorry.image.original_filename).first.to_s if @casestorry.image.original_filename.present?
      @casestorry.save
      create! {casestorry_path(@casestorry)}
    end
    
#    def create  
#      @illustration = Illustration.new(params[:illustration])
#      @illustration.image_content_type = MIME::Types.type_for(@illustration.image.original_filename).first.to_s if @illustration.image.original_filename.present?
#      @illustration.save
#      create! {illustration_path(@illustration)}
#    end
  
private  
  def sort_column  
    Illustration.column_names.include?(params[:sort]) ? params[:sort] : "created_at"  
  end 
  
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"  
  end
    
    
end

