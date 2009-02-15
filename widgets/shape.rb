class Shape
  def click( event )
    abs_x, abs_y = event.x, event.y
    
    if intersection?( abs_x, abs_y )
      handle_click( abs_x, abs_y )
    end
  end 
 
  def set_x_y( tuio_object )
    @x = ( @app.width  * tuio_object[:x_pos] ).to_i
    @y = ( @app.height * tuio_object[:y_pos] ).to_i
  end
  
  def update( tuio_object )
    set_x_y( tuio_object )
  end
  
  def location
    [@x, @y]
  end 

  
  # derivatives should implement
  # draw, intersection, handle_click
end