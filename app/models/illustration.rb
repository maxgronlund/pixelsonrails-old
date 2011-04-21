# encoding: utf-8
class Illustration < ActiveRecord::Base

  
  has_attached_file :image, :styles => {  :mini => "32x32", :thumbnail => "240x240" }, :default_url => "/images/fallback/default_illustration_:style.gif"
  
  validates_attachment_size :image, :less_than => 800.kilobytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/jpg','image/png']
  
  
  
  def self.with_title(title)
    where(:title => title).first
  end

  def self.logo
    with_title('logo')
  end
  
  
end

