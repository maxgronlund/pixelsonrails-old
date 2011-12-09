class CaseStudy < ActiveRecord::Base
  # Image
  attr_accessible :image, :image_cache, :remote_image_url, :remove_image
  serialize :crop_params, Hash
  mount_uploader :image, CaseImageUploader
  include ImageCrop
  
end
