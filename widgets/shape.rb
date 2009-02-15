class Shape
  def click( event )
    abs_x, abs_y = event.x, event.y
    
    if intersection?( abs_x, abs_y )
      handle_click( abs_x, abs_y )
    end
  end  
  
  # derivatives should implement
  # draw, intersection, handle_click
end