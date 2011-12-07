class GalleryImagesController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    @gallery_image = GalleryImage.new(params[:gallery_image])  
    if @gallery_image.save  
      if params[:gallery_image][:image]
        redirect_to crop_gallery_image_path(@gallery_image), :notice => "Signed up!"
      else
        redirect_to gallery_image_path(@gallery_image), :notice => "Signed up!"
      end
    else  
      render "new"  
    end  
  end  
  
  
  def crop
    @crop_version = (params[:version] || :large).to_sym
    @gallery_image.get_crop_version! @crop_version
    @version_geometry_width, @version_geometry_height = GalleryImageUploader.version_dimensions[@crop_version]
  end

  def crop_update
  #  @gallery_image = current_gallery_image                        #!!! current gallery_image? no no no 
    @gallery_image = GalleryImage.find(params[:id])
    @gallery_image.crop_x = params[:gallery_image]["crop_x"]
    @gallery_image.crop_y = params[:gallery_image]["crop_y"]
    @gallery_image.crop_h = params[:gallery_image]["crop_h"]
    @gallery_image.crop_w = params[:gallery_image]["crop_w"]
    @gallery_image.crop_version = params[:gallery_image]["crop_version"]
    @gallery_image.save

    redirect_to edit_gallery_image_path(@gallery_image)
  end
  
  
  
  
end
