class SliderWidget < Shape
  WIDTH = 20
  HEIGHT = 80
  
  def initialize( app, tuio_object )
    @app = app
    @x = ( tuio_object[:x_pos] * @app.width ).to_i
    @y = ( tuio_object[:y_pos] * @app.height ).to_i
    @channel = tuio_object[:class_id]
    @value = 0
  end
  
  def draw
    @app.rect( @x, @y, WIDTH, HEIGHT )
  end
  
private
  def handle_click( abs_x, abs_y )
    @value  = (( @y + HEIGHT + 1 ) - abs_y) / HEIGHT
    @value = ( @value * 127).to_i
    # @app.midi.slider( @channel, @value )
  end
  
  def intersection?(x, y)
    x >= @x && x <= @x + WIDTH && y >= @y && y < @y + HEIGHT
  end
  
end



# 100
# .
# .
# .103
# .
# .
# .
# .
# .
# .
# .
# 110