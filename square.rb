class Square < Shape
  RED = [100, 0, 0]
  GREEN = [0, 100, 0]
  BLUE = [0, 0, 100]
  WIDTH = 20
  
  def initialize(app, tuio_object)
    @app = app
    @tuio_object = tuio_object
    @x = (@app.width  * @tuio_object[:x_pos]).to_i
    @y = (@app.height * @tuio_object[:y_pos]).to_i
  end
  
  def draw
    draw_square( @x, @y, *RED )
    draw_square( @x + WIDTH, @y, *BLUE )
    draw_square( @x + WIDTH*2, @y, *GREEN )
    
  end
  
private
  
  def intersection?(x, y)
    x > @x && x < @x+WIDTH*3 && y > @y && y < y+WIDTH
  end
  
  def handle_click(x, y)
    puts "RED" if red?(x, y)
    puts "BLUE" if blue?(x, y)
    puts "GREEN" if green?(x, y)
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