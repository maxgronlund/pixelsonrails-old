class HomeController < ApplicationController
  
  def index
    @menu = 'home'
    session[:go_to_after_edit] = root_path
    @welcome = TextContent.welcome
    @images = GalleryImage.order('sorting asc')#.limit(3)
    @thumbs = CaseStudy.order('sorting asc').limit(6)
    
    #@gallery_images = GalleryImage.order('sorting asc').limit(10)
  end

end
