# encoding: utf-8
ILLUSTRATIONS = [
'logo'
] if !defined?(ILLUSTRATIONS)

ILLUSTRATIONS.each do |title|
  Illustration.find_or_create_by_title(title)
end


#PAGES = [
#'velkommen',
#'welcome',
#'om',
#'about'
#] if !defined?(PAGES)
#
#PAGES.each do |identity|
#  Page.find_or_create_by_identity(identity)
#end

User.create(:email => "max@synthmax.dk", :password => "rosalina", :role => "super", :name => "Max", :language => "dk")

Page.create(:identity => "welcome_dk" , :title => 'Velkommen', :body => 'formålet med denne side kan beskrives her', :language => "dk")
Page.create(:identity => "welcome_en" , :title => 'Welcome', :body => 'The purpose of this site can be explained here', :language => "en")
Page.create(:identity => "about_dk" , :title => 'Om denne side', :body => 'En forklaring af, sidens forfattere, formål e.t.c.', :language => "dk")
Page.create(:identity => "about_en" , :title => 'About this site', :body => 'An explanation of the site. The authors. and the values', :language => "en")
