class MetaWidget
  attr_reader :widgets
  attr_reader :title
  
  PADDING = 5
  
  def initialize( app, tuio_object, title = "Default")
    @app = app
    @tuio = tuio_object
    @title = title
    
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
end