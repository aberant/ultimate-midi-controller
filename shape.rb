class Shape
  def click(x, y)
    if intersection?(x, y)
      handle_click(x, y)
    end
  end  
  
  # derivatives should implement
  # draw, intersection, handle_click
end