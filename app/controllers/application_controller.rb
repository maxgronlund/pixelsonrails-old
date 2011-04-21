# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
 before_filter :set_locale
 
 
 def set_locale
   I18n.locale = 'en'
   I18n.locale = session[:locale] || 'en'
  #   if user_signed_in?
  #     I18n.locale = session[:locale] || current_user.language
  #   else
  #     #I18n.locale = 'dk'
  #     I18n.locale = session[:locale] || 'en'
  #   end
 end
 
 def default_url_options(options={})
   { :locale => I18n.locale }
 end

  
end
