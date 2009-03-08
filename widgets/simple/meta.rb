require File.expand_path( File.join( File.dirname(__FILE__), "shape"))

class MetaWidget < Shape
  attr_reader :widgets
  attr_reader :title
  
  PADDING = 5
  
  def initialize( app, tuio_object, title = "Default")
    @app = app
    @tuio = tuio_object
    @title = title
    @x = tuio_object[:x_pos]
    @y = tuio_object[:y_pos]
    
    @widgets = []
  end
  
  def widgets
    @widgets
  end
  
  def add_widget( widget )
    @widgets << widget
  end
  
  def draw
    @app.push_matrix
    @app.fill 255, 0, 0
    @app.rect(@x, @y, my_width, my_height)
    
    @widgets.each do | w |
      w.draw
    end
    
    @app.pop_matrix
  end
   
  def my_width
    @widgets.inject(0){ | result, widget | result + widget.width } + PADDING
  end
  
  def my_height
    @widgets.inject(0){ | result, widget | result + widget.height } + PADDING
  end
  
private
  
  def intersection?( x,y )
    false
  end
end