class CaseImage < ActiveRecord::Base
  belongs_to :case_study
  mount_uploader :image, CaseImageUploader
  
  #attr_accessible :image, :image_text, :case_study_id
  
end
