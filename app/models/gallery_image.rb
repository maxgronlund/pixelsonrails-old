class GalleryImage < ActiveRecord::Base
  
  # Image
  attr_accessible :image, :image_cache, :remote_image_url, :remove_image, :sorting, :title, :body
  serialize :crop_params, Hash
  mount_uploader :image, GalleryImageUploader
  include ImageCrop
  
  
end
