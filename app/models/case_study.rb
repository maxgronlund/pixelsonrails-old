class CaseStudy < ActiveRecord::Base
  # Image
  attr_accessible :image, :image_cache, :remote_image_url, :remove_image, :title, :body, :task, :year, :client, :sorting, :image_text
  serialize :crop_params, Hash
  mount_uploader :image, CaseStudyImageUploader
  include ImageCrop
  
  has_many :case_images
  
end
