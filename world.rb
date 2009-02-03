class World
  def initialize(app)
    @app = app
    @things = {}
  end
  
  def draw( tuio_object )
    thing = Square.new(@app, tuio_object)
    @things[tuio_object[:class_id]] = thing
    thing.draw
  end
  
  def click(x, y)
    @things.values.each do |thing|
      thing.click(x, y)
    end
  end
end

class Shape
  def click(x, y)
    if intersection?(x, y)
      handle_click(x, y)
    end
  end  
  
  # derivatives should implement
  # draw, intersection, handle_click
end

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

  def draw
    # @app.fill( *RED )
    # @app.rect(  @x, @y, WIDTH, WIDTH)
    draw_square( @x, @y, *RED )

    @app.fill( *BLUE )
    @app.rect( @x + WIDTH, @y, WIDTH, WIDTH)
    
    @app.fill( *GREEN )
    @app.rect( @x + WIDTH*2, @y, WIDTH, WIDTH)
  end
  
  def draw_square( x, y, red, green blue )
    @app.fill( red, green, blue )
    @app.rect( x, y, WIDTH, WIDTH)
  end
end