class NextPrevWidget < Shape
  RED = [100, 0, 0]
  GREEN = [0, 100, 0]
  BLUE = [0, 0, 100]
  WIDTH = 20
  

  
  def initialize(app, tuio_object)
    @app = app
    # @tuio_object = tuio_object
    set_x_y( tuio_object )
  end
  
  def draw
    draw_square( @x, @y, *RED )
    draw_square( @x + WIDTH, @y, *BLUE )
    draw_square( @x + WIDTH*2, @y, *GREEN )
  end
 
  
private
  
  def intersection?(x, y)
    x > @x && x < @x+(WIDTH*3) && y > @y && y < y+WIDTH
  end
  
  def handle_click(x, y)
    @app.midi.prev if red?(x, y)
    @app.midi.play if blue?(x, y)
    @app.midi.next if green?(x, y)
  end
  
  def red?(x, y)
    x > @x && x < @x+WIDTH && y > @y && y < y+WIDTH
  end

  def blue?(x, y)
    x > @x+WIDTH && x < @x+WIDTH*2 && y > @y && y < y+WIDTH
  end

  def green?(x, y)
    x > @x+WIDTH*2 && x < @x+WIDTH*3 && y > @y && y < y+WIDTH
  end
  
  def draw_square( x, y, red, green, blue )
    @app.fill( red, green, blue )
    @app.rect( x, y, WIDTH, WIDTH)
  end
end