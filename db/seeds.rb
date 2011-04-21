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

