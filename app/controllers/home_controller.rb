# encoding: utf-8
class HomeController < ApplicationController
  
  def index
    
#    @logo = Illustration.logo
    

   @casestorries = Casestorry.limit(6).order('created_at DESC')
   @blogs = Blog.limit(6).order('created_at DESC')

    
    case locale.to_s
      when 'dk' then @welcome = Page.welcome_dk
      when 'en' then @welcome = Page.welcome_en
    end
    
  end
end
