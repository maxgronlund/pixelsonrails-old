# encoding: utf-8
class Casestorry < ActiveRecord::Base
  
  has_attached_file :image, :styles => {  :mini => "32x32", :thumbnail => "238x146#",:full => "754x754#", :editing => "582x582#" }, :default_url => "/images/fallback/default_casestorry_:style.jpg"
  
  validates_attachment_size :image, :less_than => 800.kilobytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png']
  
  
  CATEGORY = [['Identity', 'identity'],
              ['logo','logo'],
              ['Flash','flash'],
              ['Community sites','community']]
  
  
end
