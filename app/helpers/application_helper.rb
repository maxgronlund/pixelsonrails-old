
module ApplicationHelper 
  
  def will_paginate(collection, options = {})
    options.merge!({
      #:previous_label => t( 'previous'),
      #:next_label => (t 'next')
      :previous_label => t( 'previous'),
      :next_label => (t 'next')
    })
    
    super(collection, options)
  end


   
  def sortable(column, title = nil)  
    title ||= column.titleize  
    css_class = (column == sort_column) ? "#{sort_direction}" : nil  
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}   
  end

  def can_edit?
    user_signed_in? && current_user.admin_or_super?
  end
  
end