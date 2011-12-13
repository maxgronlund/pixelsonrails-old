module ApplicationHelper
  
  def sortable(column, title = nil)  
    title ||= column.titleize  
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}   
  end
  
#  def markdown(text)
#      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
#                                          :autolink => true, 
#                                          :space_after_headers => true)
#      markdown.render(text).html_safe  
#     
#  #  options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
#  #  Redcarpet.new(text, *options).to_html.html_safe
#  end
  
  def can_edit?
    user_signed_in? && current_user.admin_or_super?
  end
  
  def grid_is_on?
    Rails.env == 'development' && (user_signed_in? && current_user.grid?)
  end
  
  
  
  
  
  def markdown(text, *renderer)      
    redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true, 
    :gh_blockcode => true, 
    :safe_links_only => true, 
    :filter_html => true))
    redcarpet.render(text).html_safe
  end


  
  
  
end
